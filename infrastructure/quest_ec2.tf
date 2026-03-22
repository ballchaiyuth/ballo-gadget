resource "aws_instance" "quest_ec2" {
  ami           = "ami-0f12cdd36bf3fe4c7" # Amazon Linux 2023 x86_64 (Thailand Region)
  instance_type = "t3.micro"

  tags = {
    Name = "BalloGadget-Quest-EC2"
  }
}
