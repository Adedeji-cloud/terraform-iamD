resource "aws_subnet" "private" {

  for_each = local.private_subnets

  vpc_id = aws_vpc.this.id

  cidr_block = each.value.cidr

  availability_zone = each.key

  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-private-subnet-${each.value.name}"
    }
  )
}