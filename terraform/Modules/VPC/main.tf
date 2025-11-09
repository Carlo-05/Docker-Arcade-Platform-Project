locals {
  default_tags = var.region
  az = [
    "${var.region}a",
    "${var.region}b"
  ]
}

resource "aws_vpc" "MyVPC" {

    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true

    #Tag
    tags = merge(var.default_tags, {Name = var.vpc_tag})
}

resource "aws_internet_gateway" "MyIGW" {
    vpc_id = aws_vpc.MyVPC.id

    # Tags
    tags = merge(var.default_tags, {Name = var.igw_tag})
}

resource "aws_subnet" "public_subnet" {
    count = var.public_subnet_count
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
    vpc_id = aws_vpc.MyVPC.id
    availability_zone = element(local.az, count.index % 2)
    map_public_ip_on_launch = true
    
    # Tags
    tags = merge(var.default_tags, {Name = "${var.public_subnet_tag}-${count.index + 1}"})  
}

resource "aws_subnet" "private_subnet" {
    count = var.private_subnet_count
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 10)
    vpc_id = aws_vpc.MyVPC.id
    availability_zone = element(local.az, count.index % 2)

    # Tags
    tags = merge(var.default_tags, {Name = "${var.private_subnet_tag}-${count.index + 1}"})  
  
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.MyVPC.id

    # Tags
    tags = merge(var.default_tags, {Name = var.public_RT_tag})

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.MyIGW.id
    }
}

resource "aws_route_table" "private_route_table" {
    count = var.env == "prod" ? 1 : 0
    vpc_id = aws_vpc.MyVPC.id

    # Tags
    tags = merge(var.default_tags, {Name = var.private_RT_tag})
  
}

resource "aws_route_table_association" "public_route_table_association" {
    count = length(aws_subnet.public_subnet)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_route_table.id
  
}

resource "aws_route_table_association" "private_route_table" {
    count = length(aws_subnet.private_subnet)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_route_table[count.index].id
}