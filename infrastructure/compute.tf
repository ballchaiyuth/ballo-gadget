resource "aws_instance" "bff_server" {
  ami           = "ami-003053ab6a0d2037d" # Amazon Linux 2023 in ap-southeast-7
  instance_type = "t3.micro"
  key_name      = "pair-test-key"

  vpc_security_group_ids = [aws_security_group.bff_sg.id]

  tags = {
    Name = "BalloGadget-BFF-Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y java-25-amazon-corretto
              EOF
}

resource "aws_security_group" "bff_sg" {
  name        = "ballogadget-bff-sg"
  description = "Security group for Java BFF"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Recommendation: restrict to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "bff_public_ip" {
  value = aws_instance.bff_server.public_ip
}
