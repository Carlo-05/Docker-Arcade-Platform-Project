output "ec2_practice_public_id" {
  value = aws_instance.ec2_practice.id
}

output "ec2_practice_public_ip" {
  value = aws_instance.ec2_practice.public_ip
}