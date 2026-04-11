# Extracting the public IP address of the ec2 instance

EC2_PUBLIC_IP=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=devops-portfolio" "Name=instance-state-name,Values=running" \
        --query "Reservations[].Instances[].PublicIpAddress" \
        --output text)

echo $EC2_PUBLIC_IP

# Deployment script — copies app to EC2 and restarts it

KEY_PATH="~/.ssh/devops-portfolio-key.pem"
IMAGE_NAME="pulunuwanj/devops-portfolio-project_1:latest"

# Build the image & Push Docker hub

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME

# Deploying app to the server in a docker container

echo "Deploying app to EC2 ..."

ssh -i $KEY_PATH ubuntu@$EC2_PUBLIC_IP -yes << 'EOF' 
docker pull $IMAGE_NAME
docker compose down
docker compose up -d
echo "Deployment complete"

EOF

echo "Deployment completed - http://$EC2_PUBLIC_IP:5000"
