variable "aws_region" {
  description = "AWS region to deploy into"
  type = string
  default = "ap-southeast-2"
}
variable "project_name" {
  description = "Project name used for tagging all the resources"
  type = string
  default = "devops-portfolio"
}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}
variable "key_pair_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type = string
}
variable "dockerhub_username" {
  description = "DockerHub username for pulling the app image"
  type = string
}
variable "availability_zone" {
  description = "Availability zone for the subnet"
  type = string
  default = "ap-southeast-2a"
}
