resource "aws_eip" "nat" {
  count = length(var.private_subnets)
  vpc   = true
}
