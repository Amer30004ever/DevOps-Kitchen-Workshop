resource "aws_db_instance" "name" {
    allocated_storage = 20
    engine = "postgres"
    engine_version = "15.4"
    instance_class = "db.t3.micro"
    username = "postgres"
    password = "postgres"
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.ForgTech_subnet_group.name
    vpc_security_group_ids = [aws_security_group.ForgTech_sg.id]
    multi_az = true
    deletion_protection = true
    skip_final_snapshot = true
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = true
    backup_retention_period = 7
    delete_automated_backups = true
    storage_encrypted = true
    copy_tags_to_snapshot = true
    blue_green_update {
        enabled = true
    }
}   