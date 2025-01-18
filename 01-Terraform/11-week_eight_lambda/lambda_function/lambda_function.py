# Import the boto3 library which provides the AWS SDK for Python
import boto3
# Import the os module to access environment variables
import os

# Create an S3 client using boto3 to interact with AWS S3
s3 = boto3.client('s3')

# AWS Lambda handler function that receives the event and context
def lambda_handler(event, context):
    # Extract the source bucket name from the S3 event in the Lambda trigger
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    # Extract the key (file path) of the object that triggered the event
    object_key = event['Records'][0]['s3']['object']['key']
    # Get the destination bucket name from environment variable
    destination_bucket = os.getenv('DEST_BUCKET')

    # Create a copy_source dictionary with the source bucket and key information
    copy_source = {'Bucket': source_bucket, 'Key': object_key}
    # Copy the object from source to destination bucket using the S3 client
    s3.copy_object(Bucket=destination_bucket, CopySource=copy_source, Key=object_key)

    # Print a confirmation message with the object details
    print(f"Copied {object_key} from {source_bucket} to {destination_bucket}")
