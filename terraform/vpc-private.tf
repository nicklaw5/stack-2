# ==========================================
# == PRIVATE VPC
# ==========================================

resource "aws_vpc" "private" {
  cidr_block = "192.168.16.0/20" # 192.168.16.0 -> 192.168.31.255 [4096 IPs]

  tags = {
    Name       = "private-vpc"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PRIVATE SUBNETS
# ==========================================

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

# ==========================================
# == PRIVATE INTERNET GATEWAY
# ==========================================

resource "aws_internet_gateway" "private_vpc_igw" {
  vpc_id = aws_vpc.private.id

  tags = {
    Name       = "private-vpc-igw"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PRIVATE NAT GATEWAY ELASTIC IPS
# ==========================================

resource "aws_eip" "private_ngw_eip_a" {
  vpc = true

  tags = {
    Name       = "private-ngw-eip-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_eip" "private_ngw_eip_b" {
  vpc = true

  tags = {
    Name       = "private-ngw-eip-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_eip" "private_ngw_eip_c" {
  vpc = true

  tags = {
    Name       = "private-ngw-eip-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PRIVATE NAT GATEWAYS
# ==========================================

resource "aws_nat_gateway" "private_ngw_a" {
  allocation_id = aws_eip.private_ngw_eip_a.id
  subnet_id     = aws_subnet.private_a.id

  tags = {
    Name       = "private-ngw-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_nat_gateway" "private_ngw_b" {
  allocation_id = aws_eip.private_ngw_eip_b.id
  subnet_id     = aws_subnet.private_b.id

  tags = {
    Name       = "private-ngw-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_nat_gateway" "private_ngw_c" {
  allocation_id = aws_eip.private_ngw_eip_c.id
  subnet_id     = aws_subnet.private_c.id

  tags = {
    Name       = "private-ngw-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
