# Lambda function to handle S3 file transfers
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    """
    Lambda handler to copy files between S3 buckets
    
    Environment variables:
    - SOURCE_BUCKET: Source S3 bucket name (frogtech-us-external)
    - DEST_BUCKET: Destination S3 bucket name (frogtech-us-internal)
    """
    
    # Initialize S3 client
    s3_client = boto3.client('s3')
    
    try:
        # Get bucket names from environment variables
        source_bucket = os.environ['SOURCE_BUCKET']
        dest_bucket = os.environ['DEST_BUCKET']
        
        # Get file details from S3 event
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            
            # Copy object to destination bucket
            copy_source = {
                'Bucket': source_bucket,
                'Key': key
            }
            
            print(f"Copying {key} from {source_bucket} to {dest_bucket}")
            
            s3_client.copy_object(
                CopySource=copy_source,
                Bucket=dest_bucket,
                Key=key
            )
            
            print(f"Successfully copied {key}")
            
        return {
            'statusCode': 200,
            'body': 'Files copied successfully'
        }
            
    except Exception as e:
        print(f"Error: {str(e)}")