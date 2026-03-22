resource "aws_db_instance" "quest_rds" {
  allocated_storage    = 20
  db_name              = "ballogadget"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Password123!" # Temporary password for the quest
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true
}
