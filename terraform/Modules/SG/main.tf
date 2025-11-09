# EC2
resource "aws_security_group" "ec2_practice_SG" {
    vpc_id = var.vpc_id
    name = var.ec2_practice_SGtag
    
    #tags
    tags = merge(var.default_tags, {Name = var.ec2_practice_SGtag})
}

resource "aws_security_group_rule" "ec2_practice_SGingress" {
    security_group_id = aws_security_group.ec2_practice_SG.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
}

resource "aws_security_group_rule" "ec2_practice_SGegress" {
    security_group_id = aws_security_group.ec2_practice_SG.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  
}