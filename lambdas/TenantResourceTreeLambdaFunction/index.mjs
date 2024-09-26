/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
import pg from 'pg';
const { Client } = pg;
import pLimit from 'p-limit';
import { SecretsManagerClient, GetSecretValueCommand } from "@aws-sdk/client-secrets-manager";
import { DynamoDBClient, QueryCommand } from "@aws-sdk/client-dynamodb";

export const handler = async (event) => {
    await validateInput(event);
    
    const SECRET_ARN = process.env.SECRET_ARN;
    const SECRET = await getSecretFromSecretsManager(SECRET_ARN);

    const allEdorgQuery = `
        SELECT
        edorg.educationorganizationid,
        edorg.nameofinstitution,
        edorg.shortnameofinstitution,
        edorg.discriminator,
        edorg.id,
        COALESCE(scl.localeducationagencyid, lea.parentlocaleducationagencyid, lea.educationservicecenterid, lea.stateeducationagencyid, esc.stateeducationagencyid) AS parentid
        FROM
        edfi.educationorganization edorg
        LEFT JOIN edfi.school scl
        ON
        edorg.educationorganizationid = scl.schoolid
        LEFT JOIN edfi.localeducationagency lea 
        ON
        edorg.educationorganizationid = lea.localeducationagencyid
        LEFT JOIN edfi.educationservicecenter esc
        on 
        edorg.educationorganizationid = esc.educationservicecenterid
        WHERE edorg.discriminator in 
        ('edfi.StateEducationAgency', 'edfi.EducationServiceCenter', 'edfi.LocalEducationAgency', 'edfi.School');
    `;
    
    const allowedEdOrgQuery = `
        WITH RECURSIVE OrgsWithParents AS (
        -- Anchor member: Select the organization with the provided ID and its parent_id
        SELECT
            edorg.educationorganizationid,
            edorg.nameofinstitution,
            edorg.shortnameofinstitution,
            edorg.discriminator,
            edorg.id,
            COALESCE(scl.localeducationagencyid, lea.parentlocaleducationagencyid, lea.educationservicecenterid, lea.stateeducationagencyid, esc.stateeducationagencyid) AS parentid
        FROM
            edfi.educationorganization edorg
        LEFT JOIN edfi.school scl ON edorg.educationorganizationid = scl.schoolid
        LEFT JOIN edfi.localeducationagency lea ON edorg.educationorganizationid = lea.localeducationagencyid
        LEFT JOIN edfi.educationservicecenter esc ON edorg.educationorganizationid = esc.educationservicecenterid
        WHERE
            edorg.discriminator IN ('edfi.StateEducationAgency', 'edfi.EducationServiceCenter', 'edfi.LocalEducationAgency', 'edfi.School')
            AND edorg.educationorganizationid = ANY ($1::int[]) -- Specify the provided ID here
    
        UNION ALL
    
        -- Recursive member: Select children organizations and their parent_id
        SELECT
            edorg.educationorganizationid,
            edorg.nameofinstitution,
            edorg.shortnameofinstitution,
            edorg.discriminator,
            edorg.id,
            COALESCE(scl.localeducationagencyid, lea.parentlocaleducationagencyid, lea.educationservicecenterid, lea.stateeducationagencyid, esc.stateeducationagencyid) AS parentid
        FROM
            edfi.educationorganization edorg
        
        LEFT JOIN edfi.school scl ON edorg.educationorganizationid = scl.schoolid
        LEFT JOIN edfi.localeducationagency lea ON edorg.educationorganizationid = lea.localeducationagencyid
        LEFT JOIN edfi.educationservicecenter esc ON edorg.educationorganizationid = esc.educationservicecenterid
        JOIN OrgsWithParents owp ON scl.localeducationagencyid = owp.educationorganizationid
        	or lea.parentlocaleducationagencyid = owp.educationorganizationid
        	or lea.educationservicecenterid = owp.educationorganizationid
        	or lea.stateeducationagencyid = owp.educationorganizationid
        	or esc.stateeducationagencyid = owp.educationorganizationid
    )
    select distinct * FROM OrgsWithParents;
    `;
    
    // Read tenant from DynamoDB
    var tenants;
    if (process.env.MODE === 'MultiTenant') {
        const ddb_tenants = await getTenantFromDynamoDB(process.env.ENVLABEL + "-tenants", event.tenant);
        tenants = await Promise.all(ddb_tenants.map(parseTenants));
        if (tenants.length === 0) {
            throw new Error(`Tenant with name '${event.tenant}' not found.`);
        }
    } else {
        // In SingleTenant mode, assume default tenant name and no edorg restrictions.
        tenants = [{name: 'default', allowedEdOrgs: [], odss: [] }];
    }
    const tenant = tenants[0];
    
    // Get list of ods databases.
    const databases = await sqlQuery(`admin_${event.tenant}`, 'SELECT odsinstanceid, "name", instancetype FROM dbo.odsinstances;', SECRET);

    //In Tenants with lots of databases (1200), running in sequence can be too slow (42 minutes), and running all at once can crash the DB server. 
    //pLimit sets a maximum concurrency for the map function to allow for parallel processing, without overwhelimg the DB server.
    const limit = pLimit(10);
    const odsArray = databases.map(async (db) => {
        return limit(async () => {
            // console.log("processing: " + db);
            const ods = {
                id: db.odsinstanceid,
                name: db.name,
                dbname: `ods_${event.tenant}_${db.name}`,
                allowedEdOrgs: (db.instancetype) ? JSON.parse(db.instancetype)['allowedEdOrgs'] : [],
                edorgs: []
            };

            var allowedEdOrgs = tenant.allowedEdOrgs;
            
            if (allowedEdOrgs.length == 0 && ods.allowedEdOrgs.length > 0) {
                allowedEdOrgs = ods.allowedEdOrgs;
            }

            var parents = [];
            var edorgs = [];
            
            if (allowedEdOrgs.length > 0) {
                // Use the recursive CTE query to return only the necessary records.
                edorgs = await sqlQuery(`ods_${event.tenant}_${db.name}`, allowedEdOrgQuery, SECRET, [allowedEdOrgs]);

                // Only allowed EdOrgs can be parents.
                for (const edorg of edorgs) {
                    if (allowedEdOrgs.includes(String(edorg.educationorganizationid)) ) {
                        parents.push(edorg);
                    }
                }
            } else {
                // All EdOrgs are necessary if allowedEdOrgs is [].
                edorgs = await sqlQuery(`ods_${event.tenant}_${db.name}`, allEdorgQuery, SECRET);
                
                // EdOrgs that don't have a parent should be included at the top level of the edorgs tree.
                for (const edorg of edorgs) {
                    if (edorg.parentid === null) {
                        parents.push(edorg);
                    }
                }
            }
            
            // Find children
            for (const edorg of parents) {
                const children = findChildren(edorg, edorgs);
                if (children.length > 0) {
                    edorg.edorgs = children;
                }
                ods.edorgs.push(formatEdorg(edorg));
            }

            return ods;
            
        });
    });

    const sbe = {
        odss: await Promise.all(odsArray)
    };

    return sbe;
};


async function sqlQuery(dbname, query, SECRET, values = []) {

    const client = new Client({
        host: SECRET.host,
        user: SECRET.username,
        password: SECRET.password,
        database: dbname,
        port: 5432,
        ssl: { rejectUnauthorized: false }
    });

    //Because this lambda function only runs one sql query per database, separating the connection and query logic wouldn't be beneficial.
    try {
        await client.connect();
        const result = await client.query(query, values);
        return result.rows;
    } catch (error) {
        console.error(error, 'ERROR: Unexpected error: Could not connect to psql instance.');
    } finally {
        await client.end();
    }
}

async function getSecretFromSecretsManager(secretArn) {
    const client = new SecretsManagerClient();
    const command = new GetSecretValueCommand({ SecretId: secretArn });
    const getSecretValueResponse = await client.send(command);
    return JSON.parse(getSecretValueResponse.SecretString);
}

async function getTenantFromDynamoDB(ddbTable, tenantName) {
    const client = new DynamoDBClient();
    const command = new QueryCommand({
        TableName: ddbTable,
        KeyConditionExpression: "#name = :name",
        ExpressionAttributeNames: {
          "#name": "Name"
        },
        ExpressionAttributeValues: {
          ":name": { S: tenantName }
        }
    });   
    const response = await client.send(command);
    // console.log(response);
    return response.Items;
}

//This is a recursive function that calls itself.  There might be a more elegant way to write this.
function findChildren (parent, edorgs) {
    const outList = [];
    for (const edorg of edorgs) {
        if (edorg.parentid === parent.educationorganizationid) {
            const children = findChildren(edorg, edorgs);
            if (children.length > 0) {
                edorg.edorgs = children;
            }
            outList.push(formatEdorg(edorg));
        }
    }
    return outList;
}

//This function allows us to filter and reformat the structure of the edorg record from the database before returning it for inclusion in the output object.
function formatEdorg(edorg) {
    const model = {
        educationorganizationid: edorg.educationorganizationid,
        nameofinstitution: edorg.nameofinstitution,
        shortnameofinstitution: edorg.shortnameofinstitution,
        discriminator: edorg.discriminator,
        id: edorg.id
    };
    if ('edorgs' in edorg) {
        model.edorgs = edorg.edorgs;
    }
    return model;
}

async function parseTenants(item){
    // console.log("parsing: " + item['Name']['S']);
    const tenant = {
            name: item['Name']['S'],
            allowedEdOrgs: [],
            odss: []
        };
    if (Reflect.ownKeys(item).includes('AllowedEdOrgs')) {
        for (const eo of item['AllowedEdOrgs']['NS']) {
            tenant.allowedEdOrgs.push(eo);
        }
    } 
    return tenant;
}

async function validateInput(event) {
    if (Reflect.ownKeys(event).includes('tenant')) {
        const regex = /^[a-z0-9]{1,29}$/;
        if (!regex.test(event.tenant)) {
            throw new Error('Tenant names should include only numbers and lowercase letters, be a single word, and have a max length of 29.');
        }
    } else {
        throw new Error('tenant missing from input');
    }
}