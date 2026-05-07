resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "db-subnet-group"
    }
  )
}

resource "aws_db_instance" "db" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password123"

  skip_final_snapshot    = true

  storage_encrypted      = true

  publicly_accessible    = false

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  tags = merge(
    var.common_tags,
    {
      Name = "iac-database"
    }
  )
}