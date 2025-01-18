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

resource "aws_instance" "bastion_host" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet-1.id
    vpc_security_group_ids = [aws_security_group.ForgTech_sg.id]
    availability_zone = var.availability_zone.subnet-1
    user_data = file("psql-install.sh")
    #key_name = "forgtech-key.pem"
    tags = var.tags_all
}