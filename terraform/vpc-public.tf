# ==========================================
# == PUBLIC VPC
# ==========================================

resource "aws_vpc" "public" {
  cidr_block           = "192.168.0.0/20" # 192.168.0.0 -> 192.168.15.255 [4096 IPs]
  enable_dns_hostnames = true

  tags = {
    Name       = "vpc-public"
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
    Name       = "pub-subnet-a"
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
    Name       = "pub-subnet-b"
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
    Name       = "pub-subnet-c"
    Visibility = "public"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC FLOW LOGS
# ==========================================

resource "aws_cloudwatch_log_group" "vpc_pub_flow_logs_lg" {
  name              = "vpc-pub-flow-logs-lg"
  retention_in_days = 1

  tags = {
    Name       = "vpc-pub-flow-logs"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_flow_log" "vpc_public_fl" {
  vpc_id          = aws_vpc.public.id
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_pub_flow_logs_lg.arn
  traffic_type    = "ALL"
}

# ==========================================
# == PUBLIC INTERNET GATEWAY
# ==========================================

resource "aws_internet_gateway" "vpc_public_igw" {
  vpc_id = aws_vpc.public.id

  tags = {
    Name       = "vpc-pub-igw"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC ROUTE TABLES
# ==========================================

resource "aws_default_route_table" "vpc_pub_default_rt" {
  default_route_table_id = aws_vpc.public.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_public_igw.id
  }

  tags = {
    Name       = "vpc-pub-default-rt"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == PUBLIC ROUTE TABLE ASSOCIATIONS
# ==========================================

resource "aws_route_table_association" "pub_rta_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_default_route_table.vpc_pub_default_rt.id
}

resource "aws_route_table_association" "pub_rta_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_default_route_table.vpc_pub_default_rt.id
}

resource "aws_route_table_association" "pub_rta_assoc_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_default_route_table.vpc_pub_default_rt.id
}
