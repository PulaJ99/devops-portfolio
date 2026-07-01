variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cider" {
  description = "CIDR block for the public subnet"
  type = string
  default = "10.0.0.1/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type = string
  default = "ap-souteast-2a"
}

variable "project_name" {
    description = "Name tag applied to all resources"
    type = string
}

