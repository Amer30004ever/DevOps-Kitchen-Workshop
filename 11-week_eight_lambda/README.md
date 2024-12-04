#week_eight - Lambda
Manage file Transfer between S3 Buckets using Lambda
FrogTech company has the challenge of automating a manual process, They are using 
S3 as a public storage for external/internal parties
authenticating using IAM credentials.
There are two main S3 buckets 1. frogtech-us-external and 2. frogtech-us-internal , 
The Challenge lies in the manual actions that
operators do daily in order to move files from one S3 to another.

You’re requested to automate this process using Lambda function, utilizing the 
native SDK of AWS (i.e. Python boto3 SDK,) FrogTech
engineers have no idea about lambda. Therefore you as an expert, should provide 
them with a document containing the basics of lambda,
besides explaining:
1. Function event.
2. Function context.
3. Function environment variables.
4. layers.
5. Differences between Synchronous and Asynchronous.
as well as provide a diagram explaining the entire process of the created resources; 
Use IaC Terraform to build all resources and consider
the below requirements specifications.
1. Resources must be created at the us-east-1 region.
2. Resources must have tags as below:
a. Key: “Environment”, Value: “terraformChamps”
b. Key: “Owner”, Value: <“Your_first_name“>
3. Preferd to use variables.
Refrences:
1. What is AWS Lambda? - AWS Lambda
2. [AWS] Lambda - S3 Trigger + Terraform Project 10
3. [AWS] Lambda Concepts Essentials