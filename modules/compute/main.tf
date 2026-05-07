resource "aws_instance" "app" {
  count = var.instance_count

  ami           = var.ami
  instance_type = var.instance_type

  subnet_id = element(
    var.subnet_ids,
    count.index
  )

  associate_public_ip_address = true

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = merge(
    var.common_tags,
    {
      Name = format(
        "AppServer-%d",
        count.index + 1
      )
    }
  )
}