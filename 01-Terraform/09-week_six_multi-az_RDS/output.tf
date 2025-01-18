output "bastion_ip" {
  value = aws_instance.bastion_host.public_ip
  description = "The public IP of the Bastion host"
}

output "rds_endpoint" {
  value = aws_db_instance.Forgtech_rds.endpoint
  description = "The endpoint of the RDS instance"
}