output "vpc_id" {
  description = "ID of the vpc"
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value = aws_subnet.public_subnet
}

output "security_group_id" {
  description = "IF of the security group"
  value = aws_security_group.ec2_sg.id
}