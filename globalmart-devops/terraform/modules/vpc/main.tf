locals {
  public_subnets = {
    for index, cidr in var.public_subnets :
    var.availability_zones[index] => {
      cidr = cidr
      name = format("%02d", index + 1)
    }
  }

  private_subnets = {
    for index, cidr in var.private_subnets :
    var.availability_zones[index] => {
      cidr = cidr
      name = format("%02d", index + 1)
    }
  }
}

resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr

  enable_dns_support   = true

  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpc-01"
    }
  )
}

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-nat-eip-01"
    }
  )
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-public-rt-01"
    }
  )
}

resource "aws_route" "public_internet" {

  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-private-rt-01"
    }
  )
}

resource "aws_route" "private_nat" {

  route_table_id = aws_route_table.private.id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "public" {

  for_each = aws_subnet.public

  subnet_id = each.value.id

  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "private" {

  for_each = aws_subnet.private

  subnet_id = each.value.id

  route_table_id = aws_route_table.private.id

}