resource "aws_db_instance" "ballogadget_db" {
  allocated_storage      = 20
  db_name                = "ballogadget"
  engine                 = "postgres"
  engine_version         = "17.2"
  instance_class         = "db.t3.micro"
  username               = "balloadmin"
  password               = "BalloGadget123!" # In a real project, use sensitive variables
  parameter_group_name   = "default.postgres17"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "BalloGadget-PostgreSQL"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "ballogadget-db-sg"
  description = "Allow inbound traffic for PostgreSQL"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For local dev ease, restricted CIDR recommended for prod
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "db_endpoint" {
  value = aws_db_instance.ballogadget_db.endpoint
}
