# VPC
select_region = "west2"
cidr_block = "10.0.0.0/16"
public_subnet_count = 1
private_subnet_count = 0


#EC2
select_ami = "ubuntu"
instance_type = "t2.micro"
key_name = "test"

#tags
# local tag
ProjectName = "docker practice"
env = "dev"

#vpc tag
vpc_tag = "MyDockerVPC"
igw_tag = "MyDockerIGW"
public_subnet_tag = "public"
private_subnet_tag = "private"
public_RT_tag = "Public_Route_table"
private_RT_tag = "Private_Route_table"
#SG tag
ec2_practice_SGtag = "ec2_practice_SG"
#ec2 tag
ec2_practice_tag = "ec2_practice"