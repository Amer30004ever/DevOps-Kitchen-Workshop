resource "aws_db_instance" "name" {
    allocated_storage = var.aws_db_intance.allocated_storage
    engine = var.aws_db_intance.engine
    engine_version = var.aws_db_intance.engine_version
    instance_class = var.aws_db_intance.instance_class
    username = var.aws_db_intance.username
    password = var.aws_db_intance.password
    skip_final_snapshot = true
    db_subnet_group_name = var.aws_db_subnet_group_rds
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    storage_encrypted = true
    multi_az = true
    deletion_protection = true
}