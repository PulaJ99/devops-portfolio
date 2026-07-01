# VPC  - the private network that contain all the resources
resource "aws_vpc" "main_vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.project_name}-vpc"
        ManageBy = "terraform"
    }

}

# Public subnet - subnet where the ec2 lives
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cider
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
    ManageBy = "terraform"
  }
}

# Internet gateway - connects the vpc to the internet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
    ManageBy = terraform
  }
}

# Public Route table -  Directs traffic from the public subnet to the internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
    ManageBy = terraform
  }
}

# Associate route table with the subnet
resource "aws_route_table_association" "public_route_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security group - rules for ec2 instance
resource "aws_security_group" "ec2_sg" {
  name = "${var.project_name}-sg"
  description = "Security group for the portfolio flask app"
  vpc_id = aws_vpc.main_vpc.id 

  tags = {
    Name = "${var.project_name}-sg"
    ManageBy = "terraform"
  }

  # Allow SSH from anywhere 
  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }
  # Allow all outbound traffic
  egress = {
    from_port = 0
    to_port = 0
    cidr_block = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
    protocol = "-1"
  } 
}

# Using a different approach to create another ingress rule -  allow flask-app traffic
resource "aws_vpc_security_group_ingress_rule" "ingress_rule_flask_app" {
  from_port = 5000
  to_port = 5000
  ip_protocol = tcp
  security_group_id = aws_security_group.ec2_sg.id
  description = "Flask app access"
}