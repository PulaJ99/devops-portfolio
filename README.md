###  DevOps Portfolio Project ###

############################    Stage 1 - Flask App Deployed on AWS EC2  ############################

A Python Flask web application deployed on AWS EC2 using Linux, SSH, and AWS CLI. 
Part of a 5-stage DevOps portfolio project demonstrating infrastructure and deployment skills.

## Live Demo
http://Server_Public_IP:5000

## Architecture
- Python Flask application (app.py)
- AWS EC2 t3.micro instance (Ubuntu 24.04)
- AWS Security Group ( Inbound open for port 22 and 5000)
- Depolyed via bash script (deploy.sh)
- Region: ap-southeast-2 (Sydney)

## Full Process
- Create EC2 key pair and security group (AWS CLI)
- Launch t3.micro EC2 instance (Ubuntu 24.04 -latest recommended)
- SSH in and install Python dependencies
- Run ./deploy.sh to copy app and start

## Commands Used
- aws ec2 create-key-pair                                         : to create the key pair
- aws ec2 create-security-group                                   : to create the security group
- aws ec2 run-instances                                           : to launch the ec2 instance
- ssh -i key_file ubuntu@public_ip                                : ssh to ec2 instance
- scp -i key_file -r <file> ubuntu@public_ip:<location_to_paste>  : copy files to the server
- nohup python3 app.py > app.log 2>&1 &                           : to run in background

## What learned
- AWS EC2, key pair and security group provisioning via CLI
- Security group and inbound rules
- SSH key-based authentication
- Linux process management (nohup, ps, pkill)
- Remote file transfer with SCP
- Bash deployment scripting


############################    Stage 2 - Containerising this app with Docker  ############################

To be continued
