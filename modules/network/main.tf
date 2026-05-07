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

# -----------------------------
# Public Subnets
# -----------------------------

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

# -----------------------------
# Private Subnets
# -----------------------------

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block = cidrsubnet(
    var.vpc_cidr,
    8,
    count.index + 10
  )

  availability_zone = element(
    var.azs,
    count.index
  )

  tags = merge(
    var.common_tags,
    {
      Name = format(
        "private-subnet-%d",
        count.index + 1
      )
    }
  )
}

# -----------------------------
# Internet Gateway
# -----------------------------

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "iac-igw"
    }
  )
}

# -----------------------------
# Elastic IP for NAT Gateway
# -----------------------------

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "nat-eip"
    }
  )
}

# -----------------------------
# NAT Gateway
# -----------------------------

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.gw
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "nat-gateway"
    }
  )
}

# -----------------------------
# Public Route Table
# -----------------------------

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

# -----------------------------
# Private Route Table
# -----------------------------

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "private-route-table"
    }
  )
}

# -----------------------------
# Public Route Associations
# -----------------------------

resource "aws_route_table_association" "public_assoc" {
  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public_rt.id
}

# -----------------------------
# Private Route Associations
# -----------------------------

resource "aws_route_table_association" "private_assoc" {
  count = length(aws_subnet.private)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private_rt.id
}