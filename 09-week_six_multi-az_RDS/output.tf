output "rds_subnet_id" {
    value = aws_subnet.rds_subnet.id
}

output "server_subnet_id" {
    value = aws_subnet.server_subnet.id
}