# Lookup the available instance classes for the custom engine for the region being operated in
data "aws_rds_orderable_db_instance" "custom-oracle" {
  engine                     = "postgres" # CEV engine to be used
  engine_version             = "15.*"      # CEV engine version to be used
  #license_model              = "bring-your-own-license"
  #storage_type               = "gp3"
  preferred_instance_classes = ["db.t3.micro"]
}

# The RDS instance resource requires an ARN. Look up the ARN of the KMS key associated with the CEV.
data "aws_kms_key" "by_id" {
  key_id = "example-ef278353ceba4a5a97de6784565b9f78" # KMS key associated with the CEV
}

resource "aws_db_instance" "default" {
  allocated_storage           = 20
  #auto_minor_version_upgrade  = false                         # Custom for Oracle does not support minor version upgrades
  #custom_iam_instance_profile = "AWSRDSCustomInstanceProfile" # Instance profile is required for Custom for Oracle. See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc
  #backup_retention_period     = 7
  db_subnet_group_name        = aws_db_subnet_group.default.name
  engine                      = data.aws_rds_orderable_db_instance.custom-oracle.engine
  engine_version              = data.aws_rds_orderable_db_instance.custom-oracle.engine_version
  #identifier                  = "ee-instance-demo"
  instance_class              = data.aws_rds_orderable_db_instance.custom-oracle.preferred_instance_classes
  #kms_key_id                  = data.aws_kms_key.by_id.arn
  #license_model               = data.aws_rds_orderable_db_instance.custom-oracle.license_model
  #multi_az                    = false # Custom for Oracle does not support multi-az
  #password                    = "avoid-plaintext-passwords"
  #username                    = "test"
  #storage_encrypted           = true
  publicly_accessible = true
  skip_final_snapshot = true

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }
}