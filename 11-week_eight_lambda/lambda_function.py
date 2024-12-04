# Importing the boto3 library to interact with AWS services
import boto3

# Importing the os library to access environment variables
import os

# Initializing the S3 client from the boto3 library
s3 = boto3.client('s3')

# Defining the Lambda function handler, the entry point for the Lambda function
def lambda_handler(event, context):
    """
    Lambda handler function:
    - `event`: Contains information about the triggering event (e.g., S3 event).
    - `context`: Provides runtime information, such as remaining execution time and function metadata.
    """
    
    # Retrieving the source and destination bucket names from environment variables
    source_bucket = os.environ['SOURCE_BUCKET']  # The bucket where files are uploaded (frogtech-us-external)
    dest_bucket = os.environ['DEST_BUCKET']      # The bucket where files will be copied (frogtech-us-internal)
    
    # Iterating through each record in the event data (multiple files can trigger the Lambda)
    for record in event['Records']:
        # Extracting the name (key) of the uploaded file from the event data
        key = record['s3']['object']['key']
        
        # Preparing the source bucket and file information for the copy operation
        copy_source = {
            'Bucket': source_bucket,  # The name of the source bucket
            'Key': key                # The name of the file in the source bucket
        }
        
        # Copying the file from the source bucket to the destination bucket
        s3.copy_object(
            CopySource=copy_source,  # The source bucket and file information
            Bucket=dest_bucket,      # The destination bucket name
            Key=key                  # The name of the file in the destination bucket
        )
        
        # Logging a success message to CloudWatch Logs for debugging or monitoring
        print(f"File {key} copied from {source_bucket} to {dest_bucket}")
