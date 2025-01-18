resource "aws_db_instance" "ForgTech_db" {
    allocated_storage = var.db_instance.allocated_storage
    engine = var.db_instance.engine
    engine_version = var.db_instance.engine_version
    instance_class = var.db_instance.class
    username = var.db_instance.username
    password = var.db_instance.password
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.ForgTech_subnet_group.name
    vpc_security_group_ids = [aws_security_group.ForgTech_sg.id]
    multi_az = true
    deletion_protection = true
    skip_final_snapshot = true
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = true
    backup_retention_period = var.db_instance.backup_retention_period
    delete_automated_backups = true
    storage_encrypted = true
    copy_tags_to_snapshot = true
    blue_green_update {
        enabled = true
    }
}   