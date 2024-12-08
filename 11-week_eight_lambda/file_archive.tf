data "archive_file" "zip_the_python_code" {
  type        = "zip"                                         # Specify the archive type as ZIP
  source_dir  = "${path.module}/lambda_function/"             # Specify the source directory for lambda_function.py
  output_path = "${path.module}/lambda_function/function.zip" # Specify the output path for the ZIP file

}