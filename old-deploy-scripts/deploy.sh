#!/bin/bash

# Extracting the public IP address of the ec2 instance

EC2_PUBLIC_IP=$(aws ec2 describe-instances \
	--filters "Name=tag:Name,Values=devops-portfolio" "Name=instance-state-name,Values=running" \
	--query "Reservations[].Instances[].PublicIpAddress" \
	--output text)

echo $EC2_PUBLIC_IP

# Deployment script — copies app to EC2 and restarts it

KEY_PATH="~/.ssh/devops-portfolio-key.pem"
LOCAL_APP_DIR="~/devops-portfolio/app"
REMOTE_APP_DIR="/home/ubuntu/app"

# Copy app files to the server

scp -i $KEY_PATH -r $LOCAL_APP_DIR ubuntu@$EC2_PUBLIC_IP:$REMOTE_APP_DIR/

# SSH in to the remote server, kill current app and restart the app

ssh -i $KEY_PATH ubuntu@$EC2_PUBLIC_IP -yes << 'EOF' 
pkill -f "python3 app.py" || true
cd /home/ubuntu/app
source env/bin/activate
nohup python3 app.py > app.log 2>&1 &
echo "App restarted successfully" 

EOF

echo "Deployment completed - http://$EC2_PUBLIC_IP:5000"



