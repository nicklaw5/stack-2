resource "aws_vpc" "data" {
  cidr_block = "192.168.32.0/20" # 192.168.32.0 -> 192.168.47.255 [4096 IPs]

  tags = {
    Name       = "data-vpc"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "data_a" {
  vpc_id            = aws_vpc.data.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.32.0/24" # 192.168.32.0 -> 192.168.32.255 [256 IPs]

  tags = {
    Name       = "data-subnet-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "data_b" {
  vpc_id            = aws_vpc.data.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.33.0/24" # 192.168.33.0 -> 192.168.33.255 [256 IPs]

  tags = {
    Name       = "data-subnet-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "data_c" {
  vpc_id            = aws_vpc.data.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.34.0/24" # 192.168.34.0 -> 192.168.34.255 [256 IPs]

  tags = {
    Name       = "data-subnet-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
