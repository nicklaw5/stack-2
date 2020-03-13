resource "aws_vpc" "public" {
  cidr_block           = "192.168.0.0/20" # 192.168.0.0 -> 192.168.15.255 [4096 IPs]
  enable_dns_hostnames = true

  tags = {
    Name       = "public-vpc"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.0.0/24" # 192.168.0.0 -> 192.168.0.255 [256 IPs]

  tags = {
    Name       = "public-subnet-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.1.0/24" # 192.168.1.0 -> 192.168.1.255 [256 IPs]

  tags = {
    Name       = "public-subnet-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.private.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.2.0/24" # 192.168.2.0 -> 192.168.2.255 [256 IPs]

  tags = {
    Name       = "public-subnet-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
