###  DevOps Portfolio Project ###

############################    Stage 2 - Containerised with Docker  ############################

The Flask app is now packaged as a Docker container and deployed
on EC2 via Docker Compose.

## Docker setup
- Dockerfile using python:3.11-slim base image
- .dockerignore to keep image lean and credentials safe
- docker-compose.yml with custom bridge network (portfolio-network)
- Image published to DockerHub: hub.docker.com/r/YOURUSERNAME/devops-portfolio

## Gunicorn configuration
Configured with 3 workers and 2 threads per worker for the t3.micro instance (2 vCPU, 1GB RAM). This gives 6 concurrent request handlers while staying within the memorylimit. Timeout set to 120s to handle slow cold starts. Logs sent to stdot so they are visible via docker logs.

## How to run locally
docker compose up -d
# Visit http://localhost:5000
# Check health: http://localhost:5000/health

### How to deploy to EC2
./deploy.sh
# Builds image, pushes to DockerHub, pulls on EC2, restarts container

### What I learned
- Writing production Dockerfiles with layer caching optimisation
- Tuning Gunicorn workers and timeout for instance hardware specs
- Diagnosing and fixing worker timeout issues from container logs
- Container networking with named bridge networks
- Docker Compose for service orchestration
- Pushing and pulling images from DockerHub
- Deploying containerised apps to EC2

## Coming next — Stage 3
Provisioning all infrastructure with Terraform (IaC)



############################    Stage 1 - Flask App Deployed on AWS EC2  #####################s#######

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

## What learned
- AWS EC2, key pair and security group provisioning via CLI
- Security group and inbound rules
- SSH key-based authentication
- Linux process management (nohup, ps, pkill)
- Remote file transfer with SCP
- Bash deployment scripting



To be continued
