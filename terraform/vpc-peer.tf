# resource "aws_vpc_peering_connection" "public_to_private" {
#   peer_owner_id = data.aws_caller_identity.current.account_id
#   peer_vpc_id   = aws_vpc.public.id
#   vpc_id        = aws_vpc.private.id
#   auto_accept   = true

#   tags = {
#     Name       = "public-to-private-peer"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }

# resource "aws_vpc_peering_connection" "private_to_data" {
#   peer_owner_id = data.aws_caller_identity.current.account_id
#   peer_vpc_id   = aws_vpc.private.id
#   vpc_id        = aws_vpc.data.id
#   auto_accept   = true

#   tags = {
#     Name       = "private-to-data-peer"
#     Repository = var.repository
#     ManagedBy  = var.managed_by
#   }
# }
