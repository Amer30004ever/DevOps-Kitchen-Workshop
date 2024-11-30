# Lookup the available instance classes for the custom engine for the region being operated in
data "aws_rds_orderable_db_instance" "postgres" {
  engine                     = var.rds_orderable_db_instance.engine
  engine_version             = var.rds_orderable_db_instance.engine_version
  preferred_instance_classes = var.rds_orderable_db_instance.preferred_instance_classes
}

resource "aws_db_instance" "postgres" {
  allocated_storage           = 20
  engine                      = data.aws_rds_orderable_db_instance.custom-oracle.engine
  engine_version              = data.aws_rds_orderable_db_instance.custom-oracle.engine_version
  instance_class              = data.aws_rds_orderable_db_instance.custom-oracle.preferred_instance_classes
  multi_az                    = false # Custom for Oracle does not support multi-az
  publicly_accessible = true
  skip_final_snapshot = true
  #storage_encrypted   = true
  #storage_type        = "gp2"
  username            = var.db_instance.username
  password            = var.db_instance.password
  db_subnet_group_name        = aws_db_subnet_group.ForgTech_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ForgTech_sg.id]
  tags = {
    "Environment" = var.tags.Environment
    "Owner" = var.tags.Owner
  }
}
