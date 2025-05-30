![](https://admin.startingblocks.org/assets/starting-blocks-1ceab864.svg)

Welcome to the StartingBlocks Open Source repository! The artifacts in this repository will allow users to deploy a cloud native Ed-Fi ODS/API implementation using AWS resources. StartingBlocks is additionally inclusive of a suite of management functions that allow users to manage resources to configure their Ed-Fi deployment appropraitely for a variety of use cases.

>[!TIP]
>Documentation is available in the [docs](./docs/) folder in this repo, and at [docs.startingblocks.org](https://docs.startingblocks.org). 

# Getting Started

## Prerequisites
1.  You must have an AWS account
2.  You must have deployed a custom VPC, 2 public subnets, and 2 private subnets before deploying the StartingBlocks templates. <b>It is not advisable for users to use the default VPC initially deployed by AWS</b>.
3.  You must have created a Hosted Zone and NS record for the domain at which you intend to deploy your StartingBlocks environment(s).

If you would like more guidance and support with deploying StartingBlocks, [please reach out to our team using this form.](https://edanalytics.atlassian.net/helpcenter/products-and-services/portal/15/group/45/create/300)

## Deployment Steps
Steps to deploy StartingBlocks templates.

1.  In your AWS account, create an S3 bucket that will be used to hold the StartingBlocks templates. 
Example bucket name:
    -  `{orgname}-{environment label}-{version}-cloudformation` 
    - `EducationAnalytics-Prod2425-7.1-cloudformation`
#####
        aws s3api create-bucket --bucket my-cfn-bucket
2.  Clone the StartingBlocks OSS repository to your local workstation and checkout the relevant version branch.
    - All Ed-Fi ODS/API 7.x versions can be deployed from the StartingBlocks `7.x` branch.  Use this branch to deploy Ed-Fi API 7.1, 7.2, or 7.3.
#####
        git clone https://github.com/edanalytics/startingblocks_oss.git
        cd startingblocks_oss
        git checkout 7.x
3.  Upload the contents of the repository to your S3 bucket location. You can do this via AWS CLI or dragging the folders from your file explorer to the S3 console for your bucket.
#####
        aws s3 sync . s3://my-cfn-bucket/ --exclude ".git/*"
4.  Copy the S3 URL for the `templates > 1-StartingBlocks-Main-Template.yml` file.
#####
        https://my-cfn-bucket.s3.REGION.amazonaws.com/templates/1-StartingBlocks-Main-Template.yml
1.  Navigate to the [CloudFormation console](https://us-east-2.console.aws.amazon.com/cloudformation/) in AWS. Create a new stack with new resources.
2.  Select `Template is ready > Amazon S3 URL` and paste your copied URL for the `1-StartingBlocks-Main-Template.yml` file into the field.
3.  Enter stack parameter values. [Please read the doc here for more information on parameter values.](./docs/sbe-parameter-values.md)
4.  Navigate through the various screens until you are able to start the deployment.

## Post Deploymnet Configuration

After a successful CloudFormation deployment of the StartingBlocks stack:
1. Use the [TenantManagement](./docs/sbe-functions.md#variable-requirements) function to create Ed-Fi Tenants.
2. Use the [ODSManagement](./docs/sbe-functions.md#variable-requirements-1) function to create ODSs within Tenants.
3. Use the [EdOrgManagement](./docs/sbe-functions.md#variable-requirements-2) function to create preliminary EdOrg records within ODSs.
    - The EdOrg records created using this function are meant to be updated with full information via integrating systems. It is not meant to create comprehensive records, but rather populate enough information to create API credentials.
4. Use the [TenantManagement](./docs/sbe-functions.md#keygen) KeyGen action to create AdminAPI credentials for a given Tenant.
5. Use the AdminAPI to create application (Ed-Fi API) credentials for the Tenants.
    - [Please read the AdminAPI documentation published by the Alliance for detailed information on usage.](https://github.com/Ed-Fi-Alliance-OSS/AdminAPI-2.x)

>[!TIP]
>Education Analytics offers StartingBlocks as a managed service. [Inquire here](https://www.edanalytics.org/products/starting-blocks)!

