resource "aws_lambda_function" "s3_copy_function" {
  function_name = "terrateam-function-b"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_assume_role.arn
  filename      = "function.zip"
  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.frogtech_us_external.id # Set the source bucket
      DEST_BUCKET   = aws_s3_bucket.frogtech_us_internal.id # Set the destination bucket
    }
  }
}

# This resource grants S3 permission to invoke the Lambda function.
# It allows the S3 service to trigger the function when events occur.
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_copy_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.frogtech_us_external.arn
}

# This resource configures S3 event notifications.
# It sets up the bucket to trigger the Lambda function when objects are created.
resource "aws_s3_bucket_notification" "s3_event" {
  bucket = aws_s3_bucket.frogtech_us_external.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_copy_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
}