# StartingBlocks Management Functions
The StartingBlocks product team has created a set of management functions that are deployed alongside the Ed-Fi API/ODS that allow for ease of environment configuration. These functions are deployed as AWS Lambda Function resources during StartingBlocks delpoyment.  Please expand each section below to see more details about each function.

<details>
    <summary><b>TenantManagement</b></summary>

Because EdFi V7 introduced a new concept of "Tenant", we have decided, for expediency and administration sake, to create a function that would allow us to facilitate the creation and removal of tenants from a StartingBlocks Environment without admins needing to directly operate within the DB instance.

`TenantManagement` is a lambda function that lives within the StartingBlocks environment. It takes input in the form of JSON with expected elements and will output in both print statements (for logging) and a return of JSON with a status code.

Input is split into multiple actions that each require their own set of variables which also need to be included in the JSON object. The actions are as follows: `Add`, `Remove`, `List`, `Update`, `Reload`, `Keygen`.

## Variable requirements

**Action**

Must be chosen from one of the following {Add, Remove, List, Update, Keygen, Reload}

**TenantName**

Tenant names should include only numbers and lowercase letters, be a single word, and have a max length of 29. Technically it should conform to ^([a-z,0-9]){1,29}$

**DisplayName**

Display names should include upper and lowercase letters, numbers, dashes, underscores, spaces, and be between 3 and 256 characters. Technically it should conform to ^[a-zA-Z0-9_\-\s]{3,256}

**AllowedEdOrgs (optional)**

AllowedEdOrgs should be a list of integers in the form of [1, 2, 3].

AllowedEdOrgs is an optional parameter that will copy the given list into the Dynamo DB table for the tenant. These integers should correspond to the top level EducationOrganizationIDs (typically LEA ID) that the tenant "owns". This list is used to limit the EdOrgs returned by the TenantResourceTree function.

## Actions:

### Add

This action will create the Admin and Security databases for the tenant and then add the tenant to the Dynamo DB table. This will not generate the keys for the tenant to be able to use the AdminApi. In order to generate these you will need to run Keygen after you have added each of the tenants. Refer to [Keygen](#keygen) function below for more details.

---

**NOTE:**

After running the `Add` action, you must run `Reload` for the new tenant to be available in Ed-Fi.

---
Example input:

    {

        "Action": "Add",
        "TenantName": "examplename",
        "AllowedEdOrgs": [1, 2, 3]

    }

Example output:

    {

        "statusCode": 200,
        "body": "\"Item added successfully, and template databases cloned\""

    }

### Remove

This action will remove entry tied to the given Tenant from the DynamoDB tables and then delete the Admin and Security databases.

Example input:

    {

        "Action": "Remove",
        "TenantName": "examplename"

    }

Example output:

    {

        "statusCode": 200,
        "body": "\"Item removed successfully, and tenant-specific databases deleted\""

    }

### List

This action will list all of the current tenants that exist in the StartingBlocks environment. If a tenant exists in this table it means that an Admin and Security database exist in the database instance.

Example input:

    {

        "Action": "List"

    }

Example output:

    {

        "statusCode": 200,
        "body": [
        {

            "Name": "examplename1"

        },
        {

            "Name": "examplename2"

        }
        ]

    }

### Update

This action provides a means to update AllowedEdOrgs on existing tenants.

Example input:

    {

        "Action": "Update",
        "TenantName": "examplename",
        "AllowedEdOrgs": [1, 2, 3]

    }

Example output:

    {

        "statusCode": 200,
        "body": "Tenant AllowedEdOrgs updated successfully."

    }

### Reload

This action will regenerate the appsettings.json for the StartingBlocks environment. This causes all api servers to recognize the current list of tenants.

Example input:

    {

        "Action": "Reload"

    }

Example output:

### Keygen

This action generates the keys for use with the AdminAPI.  The generated keys have been loaded into the AdminAPI database are ready to use.

---

**NOTE:**

The DisplayName is being used as a unique key.  When this action is called with a unique DisplaName, new Admin API creds will be created and stored.  When this function is called with an existing DisplayName, AdminAPI creds with the same name will be replaced.

---

**NOTE:**

If you run "Keygen" manually and intend to use the generated credentials in Postman, you can un-escape the string by copying the value of ClientSecret (including the double quotes) into your browsers developer tools console and pressing enter.

---

Example input:

    {

        "Action": "Keygen",
        "DisplayName": "SBAA-ExampleName",
        "TenantName": "examplename"

    }

Example output:

    {

        "statusCode": 200,
        "body":  {
        "ClientId": "wbNC3fGFbGbxNNQA",
        "ClientSecret": "%5A]\"cBBQ_u?ak<UYF,2at!HUR(EGY<BVcP9vRWoe:b0I,|.ptHU`?m5?]Ou)#z?6&4}=1Ume:7YSQ1q/t8|`k.Wf5~>qM!ZG_Ay:-uz_MP`U!~_IA2.^.D~v9w75%dA"

        }

    }

</details>

<details>
    <summary><b>ODSManagement</b></summary>

`ODSManagement` is a lambda function that is deployed via CloudFormation within a Startingblocks v7+ environment. It takes input in the form of JSON with expected elements and will output both print statements and return of JSON with a status code.

This function allows admins of the environment a way to add and remove ODSs from specific tenants within the environment. This function interacts directly with the DB instance.

Input is split into multiple actions that each require their own set of variables which also need to be included in the JSON object. The actions are as follows: `Add`, `Remove`, `Update`, `ListTemplates`.

## Variable requirements

**Action**

Must be chosen from one of the following `Add`, `Remove`, `Update`, `ListTemplates`

**TenantName**

Tenant names should include only numbers and lowercase letters, be a single word, and have a max length of 29. Technically it should conform to ^([a-z,0-9]){1,29}$

**ODSName**

ODS names should include only numbers and lowercase letters, be a single word, and have a max length of 29. Technically it should conform to ^([a-z,0-9]){1,29}$

---

**NOTE:**

In StartingBlocks, there is a particular naming convention for the database names. Example: `ods_{TenantName}_{ODSName}`. Note that the `ODSName` is in fact the suffix of the whole database name and <b>does not</b> refer to the whole string name.

---

**TemplateName**

This is a name of a template ODS that already exists within the postgres environment. The list of available TemplateNames can be found by using the 'ListTemplates' action.

**AllowedEdOrgs**

This is an optional list of edorgs that limit which edorgs are picked up by the Tenant Resource Tree function, and thus limits which edorgs can be used to create applications in SBAA.  The functionality is the same as the AllowedEdOrgs parameter in the Tenant Management function, but with the scope of a single ODS.  This parameter accepts values in a few different formats.

    string: "1234"

    list of integers: [ 1234, 5678 ]

    list of strings: [ "1234", "5678" ]

## Actions:

### Add

This action first checks for an existing ODS by the given information concatenated into the correct naming scheme. [Example below: ods_examplename_prod] Assuming one does not exist it will clone a given template into a new ODS and name the resulting ODS with the correct naming scheme within a Startingblocks 7.0+ environment. A connection string will be generated and encrypted and the linking information will be added to the odsinstances table inside the Admin database of the parent tenant.

Example input:

    {

        "Action": "Add",
        "TenantName": "examplename",
        "ODSName": "prod",
        "TemplateName": "odst_default_minimal",
        "AllowedEdOrgs": [ 1234 ]

    }

Example output:

    {

        "statusCode": 200,
        "body": "ODS created successfully"

    }

### Remove

This action validates that the ODS exists and that it belongs to the given tenant. Assuming both are true it then takes the action of removing the odsinstance entry from the parent tenant's Admin database and then drops the ODS database.

Example input:

    {

        "Action": "Remove",
        "TenantName": "examplename",
        "ODSName": "prod"

    }

Example output:

    {

        "statusCode": 200,
        "body": "ODS successfully deleted and entry removed from dbo.odsinstances."

    }

### Update

This action will update the connection string that is encrypted and saved in the tenants admin database within the odsinstances table.

Example input:

    {

        "Action": "Update",
        "TenantName": "examplename",
        "ODSName": "prod"

    }

Example output:

    {

        "statusCode": 200,
        "body": "Connection string successfully updated."

    }

### ListTemplates

This action lists out the available ods templates in the StartingBlocks environment.

Example input:

    {

        "Action ": "ListTemplates"

    }

Example output:

    {

        "statusCode": 200,
        "body": {
        "Templates": [
            "odst_default_minimal",
            "odst_default_populated"
        ]
        }

    }

</details>

<details>
    <summary><b>EdOrgManagement</b></summary>

Ed Org Management is a lambda function that is deployed via Cloud Formation within a StartingBlocks v7+ environment. It takes input in the form of JSON with expected elements and will output both print statements and return of JSON with a status code.

This function allows admins to add and remove edorg records for environments that require some pre-seeding of edorgs in order to generate application credentials. The function interacts directly with the DB instance.

Input is split into multiple actions that each require their own set of variables which also need to be included in the JSON object. The actions are as follows: `Add`, `Remove`.

## Variable requirements

**Action**

Must be chosen from one of the following `Add`, `Remove`

**TenantName**

Tenant names should include only numbers and lowercase letters, be a single word, and have a max length of 29. Technically it should conform to ^([a-z,0-9]){1,29}$

**ODSName**

The name for the ODS to create or remove EdOrg records from. ODS names should include only numbers and lowercase letters, be a single word, and have a max length of 29. Technically it should conform to ^([a-z,0-9]){1,29}$

---

**NOTE:**

In StartingBlocks, there is a particular naming convention for the database names. Example: `ods_{TenantName}_{ODSName}`. Note that the `ODSName` is in fact the suffix of the whole database name and <b>does not</b> refer to the whole string name.

---

**EdOrgId**

This is the Id that will be used as an EducationOrganizationID within the EducationOrganization table.

**NameOfInstitution**

This is the name of the district in string format to be used in the EducationOrganization table.

**AddressType**

This is the type of address. The list of possible values comes from the current descriptors loaded inside the `uri://ed-fi.org/AddressTypeDescriptor` namespace from the Edfi.Descriptor table of the ODS.

**City**

This is the name of the city in string format to be used as the `city` column in the EducationOrganizationAddress table.

**Zip**

This is the number corresponding to the zip code in integer format to be used in the `postalcode` column of the EducationOrganizationAddress table.

**State**

This is the state abbreviation. This list of possible values comes from the current descriptors loaded inside the "uri://ed-fi.org/StateAbbreviationDescriptor" namespace from the `edfi.descriptor` table of the ODS.

**Address**

This is the street address of the district in string format to be used in the `streetnumbername` column of the EducationOrganization table.

**EdOrgCategory**

This is the type of education organization that will be added. This should come from the list in the `uri://ed-fi.org/EducationOrganizationCategoryDescriptor` namespace.
- Education Organization Network
- School
- Local Education Agency
- Organization Department
- Other
- Post Secondary Institution
- Education Service Center
- State Education Agency
- Educator Preparation Provider
- University

## Actions:

### Add

This action will first check to be sure that the Ed Org doesn't already exist in the given ODS. If it doesn't it will add records to the following tables respectively: `educationOrganization`, `educationOrganizationAddress`, `educationOrganizationCategory`, `localEducationAgency`, `educationOrganizationIdentificationCode`.

Example input:

    {

        "Action ": "Add",
        "TenantName": "examplename",
        "ODSName": "prod",
        "EdOrgId": "12345",
        "NameOfInstitution": "Sometown District School Systems",
        "AddressType": "Mailing",
        "City": "Sometown",
        "Zip": "54321",
        "State": "VT",
        "Address": "12345 Some Rd",
        "EdOrgCategory": "Local Education Agency"

    }

Example output:

    {

        "statusCode": 200,
        "body": "EdOrg information successfully inserted into ODS."

    }

### Remove

This action will first check to be sure that the Ed Org exists in the given ODS. If it does it will then remove records in the following tables, using the given EdOrgId as a key,  respectively: `educationOrganizationIdentificationCode`, `localEducationAgency`, `educationOrganizationCategory`, `educationOrganizationAddress`, `educationOrganization`

Example input:

    {

        "Action": "Remove",
        "TenantName": "examplename",
        "ODSName": "prod",
        "EdOrgId": "54321"

    }

Example output:

    {

        "statusCode": 200,
        "body": "EdOrg information successfully removed from ODS for 54321."

    }
</details>

<details>
    <summary><b>ODSUserPermissions</b></summary>

This function was created to assist admins in creating ODS users without needing to completely work within the DB instance.  There are some steps admins must take in the DB instance, but this function generally has 2 sets of responsibilities:

1. Grant/Revoke read only permissions to specified groups on target databases and schemas.
2. Add/Remove users from groups.

Please note that currently this function only adds <b>read only</b> permissions to a given group. If administrators would like to create groups with more permissive actions, they must follow Postgres instructions on creating groups and granting appropriate access. Admins will still be able to use this function to add and remove users from groups.

## Variable requirements

**Action**

Choose between `GrantPermissions` and `RevokePermissions` for group related actions. `AddUsers` and `RemoveUsers` for user related actions.

**GroupName**

Name of group to add/remove permissions to/from. Also used to add/remove users to/from.

**DatabaseList**

For group related actions. This database list will be used to grant/revoke group level permissions.

**SchemaList**

For group related actions. This schema list will be used to grant/revoke group level permissions.

**UserList**

For user related actions. List of users to add or remove from given group.

## Actions:

### Adding/Revoking Permissions to/from groups

### Prerequisites
1. Create an appropriate group in the DB instance.

`CREATE GROUP {prefix}_readonlygroup`

<b>To Add Permissions to a Group</b>

Invoke the `ODSUserPermissions` lambda function through the AWS console or aws-cli to add the appropriate permissions to the group. The function takes a group name and a list of databases and schemas. It will provide read only access to each schema in each database. The function assumes the provided group, databases, and schemas already exist. An example JSON payload is below.

Example Input:

    {
    "Action": "GrantPermissions",
    "GroupName": "test_readonlygroup",
    "DatabaseList": ["ods_tenant1_dev", "ods_tenant1_prod"],
    "SchemaList": ["edfi", "tpdm"]
    }

<b>To Remove Permissions from a Group</b>

Invoke the `ODSUserPermissions` lambda function through the AWS console or aws-cli to revoke permissions from the group. The function takes a group name and a list of databases and schemas. It will revoke read only access from each schema in each database. The function assumes the provided group, databases, and schemas already exist. An example JSON payload is below.

Example Input:

    {
      "Action": "RevokePermissions",
      "GroupName": "test_readonlygroup",
      "DatabaseList": [
        "ods_tenant1_dev",
        "ods_tenant1_prod"
      ],
      "SchemaList": [
        "edfi",
        "tpdm"
      ]
    }


### Adding/Removing users to/from groups

### Prerequisites
1. Create user in the Database.

`CREATE USER {username} WITH PASSWORD {password}`

<b>To Add Users to Group</b>

Invoke the `ODSUserPermissions` lambda function through the AWS console or aws-cli to add the user(s) to the appropriate group. The function takes a group name and a list of usernames, and it will add each user to the group. The function assumes the provided group and users already exist. An example JSON payload is below.

Example Input:

    {
      "Action": "AddUsers",
      "UserList": [
        "user_1",
        "user_2"
      ],
      "GroupName": "test_readonlygroup"
    }

<b>To Remove Users from Group</b>

Invoke the `{envLabel}-ODSUserPermissions` lambda function through the AWS console or aws-cli to remove the user(s) from the appropriate group. The function takes a group name and a list of usernames, and it will remove each user from the group. The function assumes the provided group and users already exist. An example JSON payload is below.

Example Input:

    {
      "Action": "RemoveUsers",
      "UserList": [
        "user_1",
        "user_2"
      ],
      "GroupName": "test_readonlygroup"
    }

</details>


# StartingBlocks Reporting Functions
There are currently 2 reporting type functions to allow for visibility into the StartingBlocks environment. One function `TenantResourceTree` allows admins to return a tree hierarchy of the different tenants, ODSs and EdOrgs within the StartingBlocks environment. The other function `DataFreshnessJson` outputs a set of row counts for each table within a given ODS and Tenant.

<details>
    <summary><b>TenantResourceTree</b></summary>

This function will return a JSON representation of resource hierarchy for a given `Tenant`. This can be helpful in identifying ownership of resources oriented around tenants in the environment.

## Variable requirements

**tenant**

Tenant name to return resource tree for.

Example Input:

    {
    "tenant": "exampletenantname"
    }

Example Output:

    {
    "odss": [
        {
        "id": 1,
        "name": "prod",
        "dbname": "ods_emtest_prod",
        "allowedEdOrgs": [],
        "edorgs": [
            {
            "educationorganizationid": "255950",
            "nameofinstitution": "Region 99 Education Service Center",
            "shortnameofinstitution": null,
            "discriminator": "edfi.EducationServiceCenter",
            "id": "5c72407b-1d2b-4ade-85f0-f9fb91b6f244",
            "edorgs": [
                {
                "educationorganizationid": "255901",
                "nameofinstitution": "Grand Bend ISD",
                "shortnameofinstitution": "GBISD",
                "discriminator": "edfi.LocalEducationAgency",
                "id": "e7977d80-c1d7-4d5a-a575-4cf23f4d09f3",
                "edorgs": [
                    {
                    "educationorganizationid": "255901107",
                    "nameofinstitution": "Grand Bend Elementary School",
                    "shortnameofinstitution": "GBES",
                    "discriminator": "edfi.School",
                    "id": "c93b2405-d834-4933-9e98-eac8bbcd1967"
                    },
                    {
                    "educationorganizationid": "255901044",
                    "nameofinstitution": "Grand Bend Middle School",
                    "shortnameofinstitution": "GBMS",
                    "discriminator": "edfi.School",
                    "id": "47626af1-5aa1-479f-a173-6c6b7fc19210"
                    },
                    {
                    "educationorganizationid": "255901001",
                    "nameofinstitution": "Grand Bend High School",
                    "shortnameofinstitution": "GBHS",
                    "discriminator": "edfi.School",
                    "id": "6b9c82ab-bc13-4875-9868-e5c015478ddd"
                    }
                ]
                }
            ]
            },
            {
            "educationorganizationid": "5",
            "nameofinstitution": "UT Austin College of Education Graduate",
            "shortnameofinstitution": null,
            "discriminator": "edfi.School",
            "id": "f33cb20d-e90a-4763-b886-2a201c67ae0e"
            },
            {
            "educationorganizationid": "6",
            "nameofinstitution": "UT Austin College of Education Under Graduate",
            "shortnameofinstitution": null,
            "discriminator": "edfi.School",
            "id": "225b6e19-4be5-4808-b0b6-fabe724ad894"
            },
            {
            "educationorganizationid": "7",
            "nameofinstitution": "UT Austin Extended Campus",
            "shortnameofinstitution": null,
            "discriminator": "edfi.School",
            "id": "ac402f08-222c-49f2-80e0-36ae92270534"
            }
        ]
        }
    ]
    }

</details>

<details>
    <summary><b>DataFreshnessJson</b></summary>

Provides a JSON output for resource counts and dates per table within a given `ODS` and `Tenant`. This provides some visibility into the ODS without needing to make API calls or connect directly to the DB instance.

## Variable requirements

**Tenant**

Name of tenant to return rowcounts for.

**ODS**

Name of ODS within tenant to return rowcounts for.

Example Input:

    {
    "Tenant": "exampletenantname",
    "ODS": "prod"
    }

Example Output:

    "[{\"Schema\": \"edfi\", \"Table\": \"academicweek\", \"RecordCount\": 0, \"FirstCreated\": null, \"LastCreated\": null, \"LastUpdated\": null}, {\"Schema\": \"edfi\", \"Table\": \"accountabilityrating\", \"RecordCount\": 4, \"FirstCreated\": \"2023-12-06T18:46:11.227767\", \"LastCreated\": \"2023-12-06T18:46:11.227781\", \"LastUpdated\": \"2023-12-06T18:46:11.226569\"}, {\"Schema\": \"edfi\", \"Table\": \"assessment\", \"RecordCount\": 24, \"FirstCreated\": \"2023-12-06T18:46:56.248244\", \"LastCreated\": \"2023-12-06T18:46:56.532913\", \"LastUpdated\": \"2023-12-06T18:46:56.532625\"}, {\"Schema\": \"edfi\", \"Table\": \"assessmentacademicsubject\", \"RecordCount\": 30, \"FirstCreated\": \"2023-12-06T18:46:56.251721\", \"LastCreated\": \"2023-12-06T18:46:56.533883\", \"LastUpdated\": null}, {\"Schema\": \"edfi\", \"Table\": \"assessmentassessedgradelevel\", \"RecordCount\": 27, \"FirstCreated\": \"2023-12-06T18:46:56.252883\", \"LastCreated\": \"2023-12-06T18:46:56.534305\", \"LastUpdated\": null},...

</details>

