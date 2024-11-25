data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name" #the name of the filter is the name of the AMI argument, which is name
      values = ["amzn2-ami-kernel-*-x86_64-gp2"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

/*output "aws_ami_id" {  # hash (resource "aws_instance" "app-server") and run terraform plan to test output
 #value = data.aws_ami.latest-amazon-linux-image #test without id to check resource details
  value = data.aws_ami.latest-amazon-linux-image.id #aws_ami_id = "ami-00ec1ed16f4837f2f", compare output with original latest
}*/

resource "aws_instance" "app-server" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "$(var.instance_type)"
  subnet_id = aws_subnet.ForgTech_subnet.id
  vpc_security_group_ids = [aws_security_group.ForgTech_security_group.id]
  associate_public_ip_address = true
  tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }

}