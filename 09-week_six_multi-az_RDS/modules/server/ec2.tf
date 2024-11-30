resource "aws_instance" "app-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.server_subnet.id
    vpc_security_group_ids = [aws_security_group.server_sg.id]
    availability_zone = var.availability_zone
    associate_public_ip_address = true
    user_data = file("../../entry-script.sh") 
    tags = var.tags_all
}