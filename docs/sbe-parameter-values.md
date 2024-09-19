# StartingBlocks Deployment Parameters
There are a large amount of parameter values needed in order to deploy a properly configured StartingBlocks environment. Some are self-explanatory and others might need additional description or guidance.  Below is a living list of parameters with some additional context. Users can expect descriptions, values, and parameters to change over time as the maintainers make improvements and accomodations to the codebase.

## Parameters
-   <b>Stack name - </b> Name your stack something unique and related to your environment.
-   <b>EnvLabel - </b> Unique name for your environment. Generally will align with the `Stack name` and be included in your S3 source bucket name.
-   <b>S3SourceBucket - </b> The name of the S3 bucket in which StartingBlocks templates are sourced. This is the bucket you created in <b>Step 1</b>
-   <b>HostedZoneId - </b> The route 53 Hosted Zone that was created as a prerequisite to deploying StaritingBlocks.
-   <b>DomainName - </b> Fully qualified domain name to create wild card certificate for.  StartingBlocks uses a wildcard certificate in order to better track api clients in logs.
-   <b>Partner - </b> The StartingBlocks product team uses this parameter to keep track of partner deployments. It is used to generate unique resource names for deployed resources.
-   <b>WebApiZipFile - </b> To use the default Api build as offered through the OSS repository, leave value as `default`. If you have a custom build of the Ed-Fi Api, construct the application zip file, and drop it in the `docker` folder in the S3 bucket created in `Step 1`. Place the name of the custom build zip file in this field if you want to deploy the custom Api.
-   <b>DatabaseArtifact - </b> To use the default database artifacts as offered through the OSS repository, leave the value as `default`. If you have custom database artifacts, upload custom artifacts to the `database` folder in the S3 bucket created in `Step 1`. Place the unique identifier for the database artifacts here.
---

**NOTE:**

Each database artifact in the `database` folder is prefixed with which database it is. i.e. EdFi_Ods_Minimal/Populated_Template for the ODS, EdFi_Security for the security database, and EdFi_Admin for the admin database. If uploading a custom build, the prefixes must stay the same, but the suffix can change, and that is what should be used as the `DatabaseArtifact` parameter value if using custom database builds. i.e. EdFi_Ods_Minimal_Template_71_patch2_20240505.sql. The value to be populated for `DatabaseArtifact` would be `71_patch2_20240505`. Note that users must have the same suffix for all database artifacts, i.e. the ods, the security and admin databases that are to be deployed must all use the same suffix.

---
-   <b>EnvironmentSize - </b> Choose the size of your resources. This parameter informs both the EC2 instance types deployed in the AutoScalig group and the database instance type for RDS.
-   <b>PostgresVersion - </b> Choose the version of Postgres to use for Aurora RDS. These versions have been tested and used by the StartingBlocks team. Versions outside of this list have not been tested.
-   <b>DatabaseType - </b> Provisioned or Serverless Aurora. Serverless will provide real time scaling, but costs more to host.
-   <b>DeployReplica - </b> Will deploy a read replica in RDS. If users anticipate a large amount of reads on the system, it might be advisable to deploy a read replica.
-   <b>EdFiTenancyMode - </b> Defines configuration for Ed-Fi API/ODS. `SingleTenant` or `MultiTenant`.
-   <b>DatabaseData - </b>  Minimal or Populated. Minimal deploys an ODS with only the Ed-Fi default descriptors and nothing else. Populated deploys an ODS with the Grand Bend test data set. Minimal is what should be used for production deployments.
-   <b>DataStandardVersion - </b> There are 2 options for 7.1 `DS5` or `DS4`. This parameter will inform which default artifacts are deployed by StartingBlocks.
-   <b>APIPublisher - </b> If users intend for the environment to be used for publishing with the API publisher, set this to `true` else `false`.
-   <b>AdminInterface - </b> Users of StartingBlocks OSS will set this to `Ed-Fi Admin Api` or `Ed-Fi Admin App` depending on whether or not a UI is needed for environment administration. `Ed-Fi Admin App` will deploy the stock admin application provided by the Ed-Fi Alliance.
-   <b>AdminAppCIDR - </b> CIDR or list of CIDRs to allow access to deployed Admin App. Currently commented out for 7.1 as there is no current release of the Admin App for Ed-Fi v7.x.
-   <b>AdminApiCIDRs - </b> List of CIDRs to allow access to call Admin API. It's advisable to add the CIDR for a user's office or locations where administration of the environment will need to be acccessible.
-   <b>AdminAccountIds - </b> StartingBlocks utilizes many management functions deployed as AWS Lambda functions. If users would like to reach these functions from another AWS account, users can input their AWS account IDs here. This will allow the management Lambda functions to be called cross account.
-   <b>WebAPIMinInstances - </b> The minimum number of EC2 instances managed by the Auto Scaling Group.
-   <b>WebAPIMaxInstances - </b> The maximum number of EC2 instances managed by the Auto Scaling Group.
-   <b>SpotFleetPercentage - </b> The percentage of On-Demand Instances as part of additional capacity that your Auto Scaling group provisions.
-   <b>WebAPIMaxPoolSize - </b> Maximun pool size for connections to the Ed-Fi ODS database. This is per database.
-   <b>WebAPIConnectionIdleLifetime - </b> Connection idle lifetime for connections to the Ed-Fi ODS database.
-   <b>WebACLArn - </b> Optionally attach a WAF (deployed separately) via ARN to the API load balancer.
-   <b>SSLPolicy - </b> Policy to determine which ssl/tls ciphers are accepted.
-   <b>SNSTopicArn - </b> Optionally add ARN of SNS topic to publish Route53 HealthCheck Alarms. SNS topic is deployed separately.
-   <b>DeploySwagger - </b> Optionally will deploy a swagger site for the StartingBlocks environment.
-   <b>SSHServerParentStack - </b> Optionally associate SSH server to StartingBlocks resources. SSH server is deployed separately.
-   <b>VpcId - </b> The VPC ID for where to deploy StartingBlocks resources. Must be deployed before StartingBlocks.
-   <b>PublicSubnet1Id - </b> The Subnet ID of a Public Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PublicSubnet2Id - </b> The Subnet ID of a Public Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PrivateSubnet1Id - </b> The Subnet ID of a Private Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PrivateSubnet2Id - </b> The Subnet ID of a Private Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.