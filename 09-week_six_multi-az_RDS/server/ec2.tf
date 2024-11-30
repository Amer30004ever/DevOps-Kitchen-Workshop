resource "aws_instance" "app-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type

    subnet_id = aws_subnet.app-subnet.id
    vpc_security_group_ids = [aws_default_security_group.default-sg.id]
    availability_zone = var.availability_zone

    associate_public_ip_address = true
    #key_name = "ubuntu-key" # key name if created from console
    key_name = aws_key_pair.ssh-key.key_name # key name if created from terraform
    
    user_data = file("entry-script.sh") 

    tags = var.tags

}

resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  #public_key = "ssh-rsa AAADSalaldASdlDSlASD2LkAS32D5l8kkjsdAL7SDoi6A5SDjl5S4DLKj21SDkj1 asds@gmail.com"
  #public_key = var.my_publick_key
  #public_key = file("id_rsa.pub")  #ssh-keygen to generate the key id_rsa.pub
  public_key = file(var.my_publick_key_location)
  #public_key = file("C:\\Users\\user\\Desktop\\id_rsa.pub") 
}