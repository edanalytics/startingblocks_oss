# StartingBlocks Management Functions
We have worked with Ed-Fi for some time to manage and administer environments with a large number of tenants. As such, we have created a set of management functions that we deploy alongside the Ed-Fi API/ODS that allow for ease of environment configuration. These functions are deployed as AWS Lambda Function resources during StartingBlocks delpoyment.  We will dive into each of these functions individually and explain what they do, why they were created, and how to interface with them.

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

This action will list all of the current tenants that exist in the DynamoDB table. A list inside this table means that the Admin and Security databases will also exist in the SQL environment.

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

This action first validates that the Tenant exists. If it does then it allows the user to update the AllowedEdOrgs column in the DynamoDB table.

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

This action will regenerate the appsettings.json for the given environment when ran. This causes all api servers to recognize the current list of tenants.

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

Previously this function returned the AdminAPI secret base 64 encoded.  It now returns the secret string directly and will follow json escaping rules.  Json clients in any programming language will handle this correctly.

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

This is the name of the ODS which will follow the tenant in the naming standard for StartingBlocks environments. Example: `ods_{TenantName}_{ODSname}`

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
</details>


# StartingBlocks Reporting Functions
There are currently 2 reporting type functions to allow for visibility into the StartingBlocks environment. One function `TenantResourceTree` allows admins to return a tree hierarchy of the different tenants, ODSs and EdOrgs within the StartingBlocks environment. The other function `DataFreshnessJson` outputs a set of row counts for each table within a given ODS and Tenant.

<details>
    <summary><b>TenantResourceTree</b></summary>
</details>

<details>
    <summary><b>DataFreshnessJson</b></summary>
</details>

