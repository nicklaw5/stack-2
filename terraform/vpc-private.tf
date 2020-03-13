resource "aws_vpc" "private" {
  cidr_block = "192.168.16.0/20" # 192.168.16.0 -> 192.168.31.255 [4096 IPs]

  tags = {
    Name       = "private-vpc"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.16.0/24" # 192.168.16.0 -> 192.168.16.255 [256 IPs]

  tags = {
    Name       = "private-subnet-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.17.0/24" # 192.168.17.0 -> 192.168.17.255 [256 IPs]

  tags = {
    Name       = "private-subnet-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.18.0/24" # 192.168.18.0 -> 192.168.18.255 [256 IPs]

  tags = {
    Name       = "private-subnet-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
