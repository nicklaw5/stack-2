# # ==========================================
# # == RESTRICTED VPC
# # ==========================================

# resource "aws_vpc" "restricted" {
#   cidr_block = "192.168.32.0/20" # 192.168.32.0 -> 192.168.47.255 [4096 IPs]

#   tags = {
#     Name       = "vpc-restricted"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# # ==========================================
# # == DATA SUBNETS
# # ==========================================

# resource "aws_subnet" "data_a" {
#   vpc_id            = aws_vpc.data.id
#   availability_zone = "${var.aws_region}a"
#   cidr_block        = "192.168.32.0/24" # 192.168.32.0 -> 192.168.32.255 [256 IPs]

#   tags = {
#     Name       = "data-subnet-a"
#     Visibility = "restricted"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# resource "aws_subnet" "data_b" {
#   vpc_id            = aws_vpc.data.id
#   availability_zone = "${var.aws_region}b"
#   cidr_block        = "192.168.33.0/24" # 192.168.33.0 -> 192.168.33.255 [256 IPs]

#   tags = {
#     Name       = "data-subnet-b"
#     Visibility = "restricted"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# resource "aws_subnet" "data_c" {
#   vpc_id            = aws_vpc.data.id
#   availability_zone = "${var.aws_region}c"
#   cidr_block        = "192.168.34.0/24" # 192.168.34.0 -> 192.168.34.255 [256 IPs]

#   tags = {
#     Name       = "data-subnet-c"
#     Visibility = "restricted"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# # ==========================================
# # == FLOW LOGS
# # ==========================================

# resource "aws_cloudwatch_log_group" "data_vpc_flow_logs_lg" {
#   name              = "data-vpc-flow-logs-lg"
#   retention_in_days = 1

#   tags = {
#     Name       = "data-vpc-flow-logs"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# resource "aws_flow_log" "data_vpc_fl" {
#   vpc_id          = aws_vpc.data.id
#   iam_role_arn    = aws_iam_role.flow_logs_role.arn
#   log_destination = aws_cloudwatch_log_group.data_vpc_flow_logs_lg.arn
#   traffic_type    = "ALL"
# }

# # ==========================================
# # == DATA ROUTE TABLES
# # ==========================================

# resource "aws_default_route_table" "data_rt_default" {
#   default_route_table_id = aws_vpc.data.default_route_table_id

#   tags = {
#     Name       = "data-rt-default"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }
