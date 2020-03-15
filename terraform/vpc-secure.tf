# ==========================================
# == PRIVATE VPC
# ==========================================

resource "aws_vpc" "secure" {
  cidr_block           = "192.168.16.0/20" # 192.168.16.0 -> 192.168.31.255 [4096 IPs]
  enable_dns_hostnames = true

  tags = {
    Name       = "vpc-secure"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE DMZ SUBNETS
# ==========================================

resource "aws_subnet" "secure_dmz_a" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.16.0/24" # 192.168.16.0 -> 192.168.16.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-dmz-a"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "secure_dmz_b" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.17.0/24" # 192.168.17.0 -> 192.168.17.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-dmz-b"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "secure_dmz_c" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.18.0/24" # 192.168.18.0 -> 192.168.18.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-dmz-c"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE PRIVATE SUBNETS
# ==========================================

resource "aws_subnet" "secure_priv_a" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.19.0/24" # 192.168.19.0 -> 192.168.19.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-priv-a"
    Visibility = "private"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "secure_priv_b" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.20.0/24" # 192.168.20.0 -> 192.168.20.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-priv-b"
    Visibility = "private"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "secure_priv_c" {
  vpc_id            = aws_vpc.secure.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.21.0/24" # 192.168.21.0 -> 192.168.21.255 [256 IPs]

  tags = {
    Name       = "sec-subnet-priv-c"
    Visibility = "private"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE FLOW LOGS
# ==========================================

resource "aws_cloudwatch_log_group" "vpc_sec_flow_logs_lg" {
  name              = "vpc-sec-flow-logs-lg"
  retention_in_days = 1

  tags = {
    Name       = "vpc-sec-flow-logs"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_flow_log" "vpc_scure_fl" {
  vpc_id          = aws_vpc.secure.id
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_sec_flow_logs_lg.arn
  traffic_type    = "ALL"
}

# ==========================================
# == SECURE INTERNET GATEWAY
# ==========================================

resource "aws_internet_gateway" "vpc_sec_igw" {
  vpc_id = aws_vpc.secure.id

  tags = {
    Name       = "vpc-sec-igw"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE NAT GATEWAY ELASTIC IPS
# ==========================================

resource "aws_eip" "sec_ngw_eip_a" {
  vpc = true

  tags = {
    Name       = "sec-ngw-eip-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_eip" "sec_ngw_eip_b" {
  vpc = true

  tags = {
    Name       = "sec-ngw-eip-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_eip" "sec_ngw_eip_c" {
  vpc = true

  tags = {
    Name       = "sec-ngw-eip-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE NAT GATEWAYS
# ==========================================

resource "aws_nat_gateway" "sec_ngw_a" {
  allocation_id = aws_eip.sec_ngw_eip_a.id
  subnet_id     = aws_subnet.secure_dmz_a.id

  tags = {
    Name       = "sec-ngw-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_nat_gateway" "sec_ngw_b" {
  allocation_id = aws_eip.sec_ngw_eip_b.id
  subnet_id     = aws_subnet.secure_dmz_b.id

  tags = {
    Name       = "sec-ngw-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_nat_gateway" "sec_ngw_c" {
  allocation_id = aws_eip.sec_ngw_eip_c.id
  subnet_id     = aws_subnet.secure_dmz_c.id

  tags = {
    Name       = "sec-ngw-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE DEFAULT ROUTE TABLE
# ==========================================

resource "aws_default_route_table" "secure_default_rt" {
  default_route_table_id = aws_vpc.secure.default_route_table_id

  tags = {
    Name       = "secure-default-rt"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE DMZ ROUTE TABLES
# ==========================================

resource "aws_route_table" "sec_dmz_rt_a" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_sec_igw.id
  }

  tags = {
    Name       = "sec-dmz-rt-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "sec_dmz_rt_b" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_sec_igw.id
  }

  tags = {
    Name       = "sec-dmz-rt-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "sec_dmz_rt_c" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_sec_igw.id
  }

  tags = {
    Name       = "sec-dmz-rt-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE DMZ ROUTE TABLE ASSOCIATIONS
# ==========================================

resource "aws_route_table_association" "sec_dmz_rta_assoc_a" {
  subnet_id      = aws_subnet.secure_dmz_a.id
  route_table_id = aws_route_table.sec_dmz_rt_a.id
}

resource "aws_route_table_association" "sec_dmz_rta_assoc_b" {
  subnet_id      = aws_subnet.secure_dmz_b.id
  route_table_id = aws_route_table.sec_dmz_rt_b.id
}

resource "aws_route_table_association" "sec_dmz_rta_assoc_c" {
  subnet_id      = aws_subnet.secure_dmz_c.id
  route_table_id = aws_route_table.sec_dmz_rt_c.id
}

# ==========================================
# == SECURE PRIVATE ROUTE TABLES
# ==========================================

resource "aws_route_table" "sec_priv_rt_a" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.sec_ngw_a.id
  }

  tags = {
    Name       = "sec-priv-rt-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "sec_priv_rt_b" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.sec_ngw_b.id
  }

  tags = {
    Name       = "sec-priv-rt-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "sec_priv_rt_c" {
  vpc_id = aws_vpc.secure.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.sec_ngw_c.id
  }

  tags = {
    Name       = "sec-priv-rt-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == SECURE PRIVATE ROUTE TABLE ASSOCIATIONS
# ==========================================

resource "aws_route_table_association" "sec_priv_rta_assoc_a" {
  subnet_id      = aws_subnet.secure_priv_a.id
  route_table_id = aws_route_table.sec_priv_rt_a.id
}

resource "aws_route_table_association" "sec_priv_rta_assoc_b" {
  subnet_id      = aws_subnet.secure_priv_b.id
  route_table_id = aws_route_table.sec_priv_rt_b.id
}

resource "aws_route_table_association" "sec_priv_rta_assoc_c" {
  subnet_id      = aws_subnet.secure_priv_c.id
  route_table_id = aws_route_table.sec_priv_rt_c.id
}
