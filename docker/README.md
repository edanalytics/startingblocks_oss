# Artifact Storage Guide

Artifacts are stored in Amazon S3, and the **`ArtifactsS3SourceBucket`** parameter determines whether to use **default artifacts** from the central S3 bucket or **custom artifacts** stored in the same directory as this README.md file.

## Choosing the Artifact Source

- If the **`ArtifactsS3SourceBucket`** parameter is set to **Use artifacts from EA's central artifact store**, artifacts will be retrieved from the **central S3 bucket**, which will be used in StartingBlocks CloudFromation stack

- If the **`ArtifactsS3SourceBucket`** parameter is set to **Use my own custom artifacts in the CloudFormation bucket**, make sure to have the artifacts saved in the same directory as this README file to be used by the StartingBlocks CloudFormation stack. 
  