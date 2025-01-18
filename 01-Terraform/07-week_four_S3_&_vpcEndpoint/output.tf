/*output "aws_ami_id" {  # hash the (resource "aws_instance" "app-server") and run terraform plan to test output
 #value = data.aws_ami.latest-amazon-linux-image #test without id to check resource details
  value = data.aws_ami.latest-amazon-linux-image.id #aws_ami_id = "ami-00ec1ed16f4837f2f", compare output with original latest
}*/