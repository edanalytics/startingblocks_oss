# StartringBlocks Deployment

## Prerequisites
1.  You must have an AWS account
2.  You must have deployed a custom VPC, 2 public subnets, and 2 private subnets before deploying the StartingBlocks templates. <b>It is not advisable for users to use the default VPC initially deployed by AWS</b>.
3.  You must have created a Hosted Zone and NS record for the domain at which you intend to deploy your StartingBlocks environment(s).

If you would like more guidance and support with deploying StartingBlocks, ![please reach out to our team using this form.]()

## Deployment Steps
Steps to deploy StartingBlocks templates.

1.  In your AWS account, create an S3 bucket that will be used to hold the StartingBlocks templates. The StartingBlocks team generally creates a new S3 bucket per environment deployed to ensure that we have some type of version control between environments if different Ed-Fi API/ODS versions are used year over year. S3 bucket names must be globally unique, i.e. you cannot have the same S3 bucket names in 2 different AWS accounts.
    - An example bucket name - {orgname}-{environment label}-{version}-cloudformation - `EducationAnalytics-Prod2425-7.1-cloudformation`
2.  Checkout the relevant version of StartingBlocks from the OSS GitHub repository and pull it to your local machine.
3.  Upload the contents of the repository to your S3 bucket location. You can do this via AWS CLI or dragging the folders from your file explorer to the S3 console for your bucket.
4.  Copy the S3 URL for the `templates > 1-StartingBlocks-Main-Template.yml` file.
5.  Navigate to the CloudFormation service in AWS. Create a new stack with new resources.
6.  Select `Template is ready > Amazon S3 URL` and paste your copied URL for the `1-StartingBlocks-Main-Template.yml` file into the field.
7.  Enter stack parameter values. ![Please read the doc here for more information on parameter values.]()
8.  Navigate through the various screens until you are able to start the deployment.
