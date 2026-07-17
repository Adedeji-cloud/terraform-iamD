resource "aws_subnet" "public" {

  for_each = local.public_subnets

  vpc_id = aws_vpc.this.id

  cidr_block = each.value.cidr

  availability_zone = each.key

  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-public-subnet-${each.value.name}"
    }
  )
}