resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project_name_vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_cidr_blocks)
  cidr_block              = element(var.public_cidr_blocks, count.index)
  availability_zone       = element(var.regions, count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_cidr_blocks)
  cidr_block              = element(var.private_cidr_blocks, count.index)
  availability_zone       = element(var.regions, count.index)
  vpc_id                  = aws_vpc.vpc.id

  tags = {
    Name = "private_subnet_${count.index}"
  }
}
