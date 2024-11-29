resource "aws_vpc" "ForgTech_log_bucket_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ForgTech_log_bucket_subnet" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    cidr_block = "10.0.1.0/24"
}

# This resource block creates a VPC endpoint for EC2 service
# vpc_id: Links this endpoint to the ForgTech_log_bucket_vpc VPC
# service_name: Specifies the AWS EC2 service in us-east-1 region to connect to
# vpc_endpoint_type: "Interface" creates an elastic network interface with a private IP
# subnet_ids: Places the endpoint in the specified subnet
# security_group_ids: Associates the endpoint with the specified security group
# private_dns_enabled: Enables private DNS for the endpoint
resource "aws_vpc_endpoint" "ec2" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    service_name = "com.amazonaws.us-east-1.ec2"
    vpc_endpoint_type = "Interface"
    subnet_ids = [aws_subnet.ForgTech_log_bucket_subnet.id]
}
