resource "aws_instance" "ec2_practice" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [var.ec2_practice_SG]
    subnet_id = var.ec2_practice_subnet
    key_name = var.key_name
    user_data = file("${path.root}/documents/docker-deploy.sh")

    # Tags
    tags = merge(var.default_tags, {Name = var.ec2_practice_tag})


}
