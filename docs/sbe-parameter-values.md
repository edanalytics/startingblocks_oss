# StartingBlocks Deployment Parameters
There are a large amount of parameter values needed in order to deploy a properly configured StartingBlocks environment. Some are self-explanatory and others might need additional description or guidance.  Below is a list of parameters with some additional context. Users can expect descriptions, values, and parameters to change over time as the maintainers make improvements and accomodations to the codebase.

## Parameters
-   <b>Stack name - </b> Name your stack something unique and related to your environment.

#### General Information
-   <b>EnvLabel - </b> Unique name for your environment. Generally will align with the `Stack name` and be included in your S3 source bucket name.
-   <b>HostedZoneId - </b> The route 53 Hosted Zone that was created as a prerequisite to deploying StaritingBlocks.
-   <b>DomainName - </b> Fully qualified domain name to create wild card certificate for.  StartingBlocks uses a wildcard certificate in order to better track api clients in logs.
-   <b>Partner - </b> The StartingBlocks product team uses this parameter to keep track of partner deployments. It is used to generate unique resource names for deployed resources.

#### Versions and Features
-   <b>EdFiApiVersion - </b> The version of the Ed-Fi API to be deployed. 
-   <b>DataStandardVersion - </b> The version of the Ed-Fi Data Standard to be deployed.  Note that not all data standard versions are supported by all Ed-Fi Api versions.
    | EdFiApiVersion | Supported DataStandardVersion |
    | -------------- | ----------------------------- |
    | 7.1            | DS4, DS5                      |
    | 7.2            | DS4, DS5.1                    |
    | 7.3            | DS4, DS5.2                    |
-   <b>PostgresVersion - </b> Choose the version of Postgres to use for Aurora RDS. These versions have been tested and used by the StartingBlocks team. Versions outside of this list have not been tested.
-   <b>AdminInterface - </b> Currently only two options are available. `Ed-Fi Admin Api` or `None`.
-   <b>DeploySwagger - </b> Optionally will deploy a swagger site for the StartingBlocks environment.
-   <b>APIPublisher - </b> If users intend for the environment to be used for publishing with the API publisher, set this to `true` to support snapshots with Aurora clones.

#### Deployment Files
-   <b>S3SourceBucket - </b> The name of the S3 bucket in which StartingBlocks templates are sourced. This is the bucket you created in [Step 1](../README.md#deployment-steps) of the deployment steps.
-   <b>ArtifactsS3SourceBucket - </b> Determines if the deployment should use EA's central artifact store (available in all US regions), or look for custom artifacts in the cloudformation bucket named above.
-   <b>WebApiZipFile - </b> To use the default Api build as offered through EA's central artifact store, leave value as `default`. If you have a custom build of the Ed-Fi Api, construct the application zip file, and drop it in the `docker` folder in the S3 bucket created in [Step 1](../README.md#deployment-steps). Place the name of the custom build zip file in this field if you want to deploy the custom Api.
-   <b>DatabaseArtifact - </b> To use the default database artifacts as offered through EA's central artifact store, leave the value as `default`. If you have custom database artifacts, upload custom artifacts to the `database` folder in the S3 bucket created in [Step 1](../README.md#deployment-steps). Place the unique identifier for the database artifacts here.

>[!NOTE]
>Each database artifact in the `database` folder is prefixed with which  database it is. i.e. EdFi_Ods_Minimal_Template and EdFi Ods_Populated_Template for the ODS, EdFi_Security for the security database, and EdFi_Admin for the admin database. If uploading a custom build, the prefixes must stay the same, but the suffix can change, and that is what should be used as the `DatabaseArtifact` parameter value if using custom database builds. i.e. EdFi_Ods_Minimal_Template_71_patch2_20240505.sql. The value to be populated for `DatabaseArtifact` would be `71_patch2_20240505`. Note that users must have the same suffix for all database artifacts, i.e. the ods, the security and admin databases that are to be deployed must all use the same suffix.

#### Ed-Fi Options
-   <b>EdFiTenancyMode - </b> Defines configuration for Ed-Fi API/ODS. `SingleTenant` or `MultiTenant`.
-   <b>DatabaseData - </b>  Minimal or Populated. Minimal deploys an ODS with only the Ed-Fi default descriptors and nothing else. Populated deploys an ODS with the Grand Bend test data set. Minimal is what should be used for production deployments.  This parameter only affects SingleTenant mode deployments. In SingleTenat deployments a default ODS is created as part of the CloudFormation process, and this parameters selects the template to use.  In MultiTenant deployments both templates are imported and available to create ODSs later as needed.
-   <b>BearerTokenPerClientLimit - </b> Introduced in Ed-Fi 7.3, this setting controls the maxium number of tokens that can be issued per client, within the span of a token lifetime.

#### Capacity and Scaling
-   <b>EnvironmentSize - </b> Choose the size of your resources. This parameter informs both the EC2 instance types deployed in the Auto Scaling Group and the database instance type for RDS.
-   <b>WebAPIMinInstances - </b> The minimum number of EC2 instances managed by the Auto Scaling Group.
-   <b>WebAPIMaxInstances - </b> The maximum number of EC2 instances managed by the Auto Scaling Group.
-   <b>SpotFleetPercentage - </b> The percentage of On-Demand Instances as part of additional capacity that your Auto Scaling Group provisions.
-   <b>DatabaseType - </b> Provisioned or Serverless Aurora. Serverless will provide real time scaling, but costs more to host.
-   <b>DeployReplica - </b> Will deploy a read replica in RDS. If users anticipate a large amount of reads on the system, it might be advisable to deploy a read replica.
-   <b>WebAPIMaxPoolSize - </b> Maximun pool size for connections to the Ed-Fi ODS database. This is per database.
-   <b>WebAPIConnectionIdleLifetime - </b> Connection idle lifetime for connections to the Ed-Fi ODS database.

#### Security Options
-   <b>SSLPolicy - </b> Policy to determine which ssl/tls ciphers are accepted.
-   <b>AdminApiCIDRs - </b> List of CIDRs to allow access to call Admin API. It's advisable to add the CIDR for a user's office or locations where administration of the environment will need to be acccessible.
-   <b>AdminAccountIds - </b> StartingBlocks utilizes many management functions deployed as AWS Lambda functions. If users would like to reach these functions from another AWS account, users can input their AWS account IDs here. This will allow the management Lambda functions to be called cross account.
-   <b>WebACLArn - </b> Optionally attach a WAF (deployed separately) via ARN to the API load balancer.
-   <b>SSHServerParentStack - </b> Optionally associate SSH server to StartingBlocks resources. SSH server is deployed separately.

#### Monitoring and Alerting
-   <b>S3AccessLogBucket - </b> Optionally store Elastic Load Balancer access logs in the S3 bucket named here.
-   <b>SNSTopicArn - </b> Optionally add ARN of SNS topic to publish Route53 HealthCheck Alarms. SNS topic is deployed separately.
-   <b>SlackWebhookUrl - </b> Optionally add a slack webhook URL to surface alerts from Beanstalk and RDS environments.

#### Maintenance Options
-   <b>DeploymentStrategy - </b> RollingWithAdditionalBatch will deploy new code and platform updates by adding new servers one at a time. This option avoids downtime and is recommended for production deployments. AllAtOnce will deploy new code and platform updates to every server at the same time. This option is faster but the environment will be unavailable until the deployment is complete.
-   <b>BeanstalkPlatformUpdateTime - </b> If provided, this will determine the day of week and time of day that Beanstalk will automatically update the platform version.  Updating the platform version is important to ensure the system is running with the latest OS patches.

#### VPC Network Configuration
-   <b>VpcId - </b> The VPC ID for where to deploy StartingBlocks resources. Must be deployed before StartingBlocks.
-   <b>PublicSubnet1Id - </b> The Subnet ID of a Public Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PublicSubnet2Id - </b> The Subnet ID of a Public Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PrivateSubnet1Id - </b> The Subnet ID of a Private Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.
-   <b>PrivateSubnet2Id - </b> The Subnet ID of a Private Subnet in one of the Availability Zones. Must be configured before StartingBlocks deployment.