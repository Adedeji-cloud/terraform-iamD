resource "aws_nat_gateway" "this" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[var.availability_zones[0]].id

  connectivity_type = "public"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-nat-01"
    }
  )

  depends_on = [
    aws_internet_gateway.this
  ]
}