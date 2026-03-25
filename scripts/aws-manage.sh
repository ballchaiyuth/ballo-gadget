#!/bin/bash

# Configuration
REGION="ap-southeast-7"
PROFILE="ballo-gadget"
EC2_INSTANCE_ID="i-08fd949c63fbd99ff"
RDS_INSTANCE_ID="terraform-20260322152338308800000001"

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
    echo "📊 Checking Resources Status in Bangkok..."
    EC2_STATUS=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --profile $PROFILE --region $REGION --query "Reservations[0].Instances[0].State.Name" --output text)
    RDS_STATUS=$(aws rds describe-db-instances --db-instance-identifier $RDS_INSTANCE_ID --profile $PROFILE --region $REGION --query "DBInstances[0].DBInstanceStatus" --output text)
    echo "--------------------------------"
    echo "EC2 Server : $EC2_STATUS"
    echo "RDS Database: $RDS_STATUS"
    echo "--------------------------------"
else
    echo "Usage: ./scripts/aws-manage.sh [start|stop|status]"
fi
