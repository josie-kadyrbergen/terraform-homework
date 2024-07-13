provider aws {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = "kaizen"
  }
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[0]
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_names[0]
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[1]
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_names[1]
  }
}

resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[2]
  availability_zone = "${var.region}c"
  map_public_ip_on_launch = false

  tags = {
    Name = var.subnet_names[2]
  }
}

resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[3]
  availability_zone = "${var.region}d"
  map_public_ip_on_launch = false

  tags = {
    Name = var.subnet_names[3]
  }
}

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }

  tags = {
    Name = var.route_table_names[0]
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.route_table_names[1]
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "private1" {
  subnet_id = aws_subnet.private1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.private2.id
  route_table_id = aws_route_table.private-rt.id
}