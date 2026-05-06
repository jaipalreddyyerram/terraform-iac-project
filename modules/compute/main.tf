resource "aws_instance" "app" {
  ami                    = "ami-0d682f26195e9ec0f"
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "AppServer"
  }
}