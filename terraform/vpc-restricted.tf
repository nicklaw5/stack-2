# ==========================================
# == RESTRICTED VPC
# ==========================================

resource "aws_vpc" "restricted" {
  cidr_block = "192.168.32.0/20" # 192.168.32.0 -> 192.168.47.255 [4096 IPs]

  tags = {
    Name       = "vpc-restricted"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == RESTRICTED SUBNETS
# ==========================================

resource "aws_subnet" "restricted_a" {
  vpc_id            = aws_vpc.restricted.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = "192.168.32.0/24" # 192.168.32.0 -> 192.168.32.255 [256 IPs]

  tags = {
    Name       = "rest-subnet-a"
    Visibility = "restricted"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "restricted_b" {
  vpc_id            = aws_vpc.restricted.id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "192.168.33.0/24" # 192.168.33.0 -> 192.168.33.255 [256 IPs]

  tags = {
    Name       = "rest-subnet-b"
    Visibility = "restricted"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_subnet" "restricted_c" {
  vpc_id            = aws_vpc.restricted.id
  availability_zone = "${var.aws_region}c"
  cidr_block        = "192.168.34.0/24" # 192.168.34.0 -> 192.168.34.255 [256 IPs]

  tags = {
    Name       = "rest-subnet-c"
    Visibility = "restricted"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == FLOW LOGS
# ==========================================

resource "aws_cloudwatch_log_group" "restricted_vpc_flow_logs_lg" {
  name              = "restricted-vpc-flow-logs-lg"
  retention_in_days = 1

  tags = {
    Name       = "restricted-vpc-flow-logs"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_flow_log" "restricted_vpc_fl" {
  vpc_id          = aws_vpc.restricted.id
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.restricted_vpc_flow_logs_lg.arn
  traffic_type    = "ALL"
}

# ==========================================
# == RESTRICTED ROUTE TABLES
# ==========================================

resource "aws_default_route_table" "restricted_rt_default" {
  default_route_table_id = aws_vpc.restricted.default_route_table_id

  tags = {
    Name       = "restricted-rt-default"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == RESTRICTED ROUTE TABLES
# ==========================================

resource "aws_route_table" "rest_rt_a" {
  vpc_id = aws_vpc.restricted.id

  route {
    cidr_block                = aws_vpc.secure.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.secure_to_restricted.id
  }

  tags = {
    Name       = "rest-rt-a"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "rest_rt_b" {
  vpc_id = aws_vpc.restricted.id

  route {
    cidr_block                = aws_vpc.secure.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.secure_to_restricted.id
  }

  tags = {
    Name       = "rest-rt-b"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

resource "aws_route_table" "rest_rt_c" {
  vpc_id = aws_vpc.restricted.id

  route {
    cidr_block                = aws_vpc.secure.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.secure_to_restricted.id
  }

  tags = {
    Name       = "rest-rt-c"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}

# ==========================================
# == RESTRICTED ROUTE TABLE ASSOCIATIONS
# ==========================================

resource "aws_route_table_association" "rest_rt_assoc_a" {
  subnet_id      = aws_subnet.restricted_a.id
  route_table_id = aws_route_table.rest_rt_a.id
}

resource "aws_route_table_association" "rest_rt_assoc_b" {
  subnet_id      = aws_subnet.restricted_b.id
  route_table_id = aws_route_table.rest_rt_b.id
}

resource "aws_route_table_association" "rest_rt_assoc_c" {
  subnet_id      = aws_subnet.restricted_c.id
  route_table_id = aws_route_table.rest_rt_c.id
}
