#!/bin/bash

# Configuration
EC2_IP="43.210.67.127"
KEY_PATH="infrastructure/keys/ballo-gadget-bff-key.pem"
JAR_PATH="services/java-bff/target/bff-0.0.1-SNAPSHOT.jar"

echo "🚀 Building JAR..."
cd services/java-bff && ./mvnw clean package -DskipTests && cd ../..

echo "📤 Uploading JAR to EC2 ($EC2_IP)..."
scp -i $KEY_PATH $JAR_PATH ec2-user@$EC2_IP:/home/ec2-user/bff.jar

echo "🏃 Starting BFF on EC2..."
ssh -i $KEY_PATH ec2-user@$EC2_IP "
  if ! command -v java &> /dev/null || ! java -version 2>&1 | grep -q '25'; then
    echo 'Installing Java 25...'
    sudo dnf install -y java-latest-openjdk # Try latest openjdk if corretto name is different
    # fallback to manual download if needed
    if ! command -v java &> /dev/null; then
       curl -L -o corretto.tar.gz https://corretto.aws/downloads/latest/amazon-corretto-25-x64-linux-jdk.tar.gz
       tar -xzf corretto.tar.gz
       export PATH=\$PWD/\$(ls -d amazon-corretto-25*)/bin:\$PATH
    fi
  fi
  nohup java -jar /home/ec2-user/bff.jar > bff.log 2>&1 &
"

echo "✅ Deployment Complete! Reachable at: http://$EC2_IP:8080/api/v1/gadgets"
