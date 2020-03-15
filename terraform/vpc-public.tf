# ==========================================
# == PUBLIC VPC
# ==========================================

resource "aws_vpc" "public" {
  cidr_block           = "192.168.0.0/20" # 192.168.0.0 -> 192.168.15.255 [4096 IPs]
  enable_dns_hostnames = true

  tags = {
    Name       = "public-vpc"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC SUBNETS
# ==========================================

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.public.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.0.0/24" # 192.168.0.0 -> 192.168.0.255 [256 IPs]

  tags = {
    Name       = "public-subnet-a"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.public.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.1.0/24" # 192.168.1.0 -> 192.168.1.255 [256 IPs]

  tags = {
    Name       = "public-subnet-b"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.public.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.2.0/24" # 192.168.2.0 -> 192.168.2.255 [256 IPs]

  tags = {
    Name       = "public-subnet-c"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == FLOW LOGS
# ==========================================

resource "aws_cloudwatch_log_group" "public_vpc_flow_logs_lg" {
  name              = "public-vpc-flow-logs-lg"
  retention_in_days = 1

  tags = {
    Name       = "public-vpc-flow-logs"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_flow_log" "public_vpc_fl" {
  vpc_id          = aws_vpc.public.id
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.public_vpc_flow_logs_lg.arn
  traffic_type    = "ALL"
}

# ==========================================
# == PUBLIC INTERNET GATEWAY
# ==========================================

resource "aws_internet_gateway" "public_vpc_igw" {
  vpc_id = aws_vpc.public.id

  tags = {
    Name       = "public-vpc-igw"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC ROUTE TABLES
# ==========================================

resource "aws_default_route_table" "public_rt_default" {
  default_route_table_id = aws_vpc.public.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_vpc_igw.id
  }

  route {
    cidr_block                = aws_vpc.private.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.public_to_private.id
  }

  tags = {
    Name       = "public-rt-default"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC ROUTE TABLE ASSOCIATIONS
# ==========================================

resource "aws_route_table_association" "public_rta_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_default_route_table.public_rt_default.id
}

resource "aws_route_table_association" "public_rta_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_default_route_table.public_rt_default.id
}

resource "aws_route_table_association" "public_rta_assoc_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_default_route_table.public_rt_default.id
}
