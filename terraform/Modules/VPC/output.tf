output "MyVPC" {
  value = aws_vpc.MyVPC.id
}

output "ec2_practice_subnet" {
  value = aws_subnet.public_subnet[*].id
  }