resource "aws_db_instance" "name" {
    allocated_storage = 20
    engine = "postgres"
    engine_version = "15.3"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "securepassword"
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.default.name
    vpc_security_group_ids = [aws_security_group.rds.id]
    storage_encrypted = true
    multi_az = true
    deletion_protection = true
    
}