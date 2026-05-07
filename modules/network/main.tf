resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "web-security-group"
    }
  )
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.common_tags,
    {
      Name = upper(var.vpc_name)
    }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block = cidrsubnet(
    var.vpc_cidr,
    8,
    count.index
  )

  availability_zone = element(
    var.azs,
    count.index
  )

  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = format(
        "public-subnet-%d",
        count.index + 1
      )
    }
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "iac-igw"
    }
  )
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "public-route-table"
    }
  )
}

resource "aws_route_table_association" "public_assoc" {
  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public_rt.id
}