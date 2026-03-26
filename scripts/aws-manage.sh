#!/bin/bash

# Configuration
REGION="ap-southeast-7"
PROFILE="ballo-gadget"
# Fetch dynamic information from Tofu state
EC2_INSTANCE_ID=$(aws ec2 describe-instances --region $REGION --profile $PROFILE --filters "Name=tag:Name,Values=BalloGadget-BFF-Server" "Name=instance-state-name,Values=running,stopped" --query "Reservations[0].Instances[0].InstanceId" --output text)
RDS_INSTANCE_ID=$(tofu -chdir=infrastructure output -raw rds_instance_id 2>/dev/null || echo "terraform-20260322152338308800000001")

COMMAND=$1
if [[ "$COMMAND" == "start" ]]; then
    echo "🌕 Starting Resources in Bangkok..."
    aws ec2 start-instances --instance-ids $EC2_INSTANCE_ID --profile $PROFILE --region $REGION
    aws rds start-db-instance --db-instance-identifier $RDS_INSTANCE_ID --profile $PROFILE --region $REGION
    echo "✅ Start commands sent. It may take a few minutes for RDS to be fully available."
elif [[ "$COMMAND" == "stop" ]]; then
    echo "🌑 Stopping Resources to save credits..."
    aws ec2 stop-instances --instance-ids $EC2_INSTANCE_ID --profile $PROFILE --region $REGION
    aws rds stop-db-instance --db-instance-identifier $RDS_INSTANCE_ID --profile $PROFILE --region $REGION
    echo "✅ Stop commands sent. Public IP will be released (for EC2) unless using Elastic IP."
elif [[ "$COMMAND" == "status" ]]; then
    CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    echo "📊 Status (at $CURRENT_TIME) in Bangkok..."
    EC2_STATUS=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --profile $PROFILE --region $REGION --query "Reservations[0].Instances[0].State.Name" --output text)
    EC2_IP=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --profile $PROFILE --region $REGION --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    RDS_STATUS=$(aws rds describe-db-instances --db-instance-identifier $RDS_INSTANCE_ID --profile $PROFILE --region $REGION --query "DBInstances[0].DBInstanceStatus" --output text)

    # Check if BFF Application is actually responding
    APP_STATUS="Down"
    if [[ "$EC2_STATUS" == "running" ]]; then
        if curl -s --connect-timeout 2 "http://$EC2_IP:8080/api/v1/gadgets" > /dev/null; then
            APP_STATUS="Ready (Healthy)"
        else
            APP_STATUS="Down (App not running)"
        fi
    fi

    echo "--------------------------------"
    echo "EC2 Server      : $EC2_STATUS ($EC2_IP)"
    echo "BFF Application : $APP_STATUS"
    echo "RDS Database    : $RDS_STATUS"
    echo "--------------------------------"
else
    echo "Usage: ./scripts/aws-manage.sh [start|stop|status]"
fi
