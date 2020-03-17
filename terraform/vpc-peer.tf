resource "aws_vpc_peering_connection" "secure_to_restricted" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.secure.id
  vpc_id        = aws_vpc.restricted.id
  auto_accept   = true

  tags = {
    Name       = "secure-to-restricted-peer"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
