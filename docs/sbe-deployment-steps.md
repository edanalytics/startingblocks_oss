# StartingBlocks Deployment

## Prerequisites
1.  You must have an AWS account
2.  You must have deployed a custom VPC, 2 public subnets, and 2 private subnets before deploying the StartingBlocks templates. <b>It is not advisable for users to use the default VPC initially deployed by AWS</b>.
3.  You must have created a Hosted Zone and NS record for the domain at which you intend to deploy your StartingBlocks environment(s).

If you would like more guidance and support with deploying StartingBlocks, [please reach out to our team using this portal.](https://edanalytics.freshdesk.com/support/home)

## Deployment Steps
Steps to deploy StartingBlocks templates.

1.  In your AWS account, create an S3 bucket that will be used to hold the StartingBlocks templates. The StartingBlocks team generally creates a new S3 bucket per environment deployed to ensure that we have some type of version control between environments if different Ed-Fi API/ODS versions are used year over year. S3 bucket names must be globally unique, i.e. you cannot have the same S3 bucket names in 2 different AWS accounts.
    - An example bucket name - `{orgname}-{environment label}-{version}-cloudformation` - `EducationAnalytics-Prod2425-7.1-cloudformation`
2.  Checkout the relevant version of StartingBlocks from the OSS GitHub repository and pull it to your local machine.
3.  Upload the contents of the repository to your S3 bucket location. You can do this via AWS CLI or dragging the folders from your file explorer to the S3 console for your bucket.
4.  Copy the S3 URL for the `templates > 1-StartingBlocks-Main-Template.yml` file.
5.  Navigate to the CloudFormation service in AWS. Create a new stack with new resources.
6.  Select `Template is ready > Amazon S3 URL` and paste your copied URL for the `1-StartingBlocks-Main-Template.yml` file into the field.
7.  Enter stack parameter values. [Please read the doc here for more information on parameter values.](sbe-parameter-values.md)
8.  Navigate through the various screens until you are able to start the deployment.

For more information on next steps after infrastructure is deployed, [read the document here about environment management.](./sbe-environment-management.md)

## StartingBlocks Environment Configuration

After infrastructure is deployed, there is some environment configuration that will need to happen before the Ed-Fi API/ODS is ready for usage. Below are some high level steps that administrators can take to ensure the environment is configured correctly. All management functions are meant to be called per `Tenant`, as such it might be a good idea to create tooling and scripts as wrappers to interact with the management functions. e.g. If your environment has multiple tenants, scripting the invocation of the AWS Lambda functions to happen in a loop might be helpful to expedite configuration.

After a successful CloudFormation deployment of the StartingBlocks stack:
1. Use the [TenantManagement](./sbe-functions.md#variable-requirements) function to create Ed-Fi Tenants.
2. Use the [ODSManagement](./sbe-functions.md#variable-requirements-1) function to create ODSs within Tenants.
3. Use the [EdOrgManagement](./sbe-functions.md#variable-requirements-2) function to create preliminary EdOrg records within ODSs.
    - The EdOrg records created using this function are meant to be updated with full information via integrating systems. It is not meant to create comprehensive records, but rather populate enough information to create API credentials.
4. Use the [TenantManagement](./sbe-functions.md#keygen) KeyGen action to create AdminAPI credentials for a given Tenant.
5. Use the AdminAPI to create application (Ed-Fi API) credentials for the Tenants.
    - [Please read the AdminAPI documentation published by the Alliance for detailed information on usage.](https://edfi.atlassian.net/wiki/spaces/ADMINAPI/pages/21300700/Technical+Information)