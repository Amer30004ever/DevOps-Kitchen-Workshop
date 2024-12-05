resource "aws_lambda_function" "example_lambda" {
  function_name = "terrateam-function-b"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_role.arn
  filename      = "function.zip"
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"                                         # Specify the archive type as ZIP
  source_dir  = "${path.module}/lambda_function/"             # Specify the source directory for the code
  output_path = "${path.module}/lambda_function/function.zip" # Specify the output path for the ZIP file

}