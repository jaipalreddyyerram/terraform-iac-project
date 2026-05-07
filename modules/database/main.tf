resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine                = "mysql"
  instance_class        = "db.t3.micro"
  username              = "admin"
  password              = "password123"
  skip_final_snapshot   = true
  storage_encrypted     = true

  tags = merge(
    var.common_tags,
    {
      Name = "iac-database"
    }
  )
}