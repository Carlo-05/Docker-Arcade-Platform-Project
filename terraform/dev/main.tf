locals {
  current_region = lookup(var.region, var.select_region, "us-west-2")
  default_tags = {
    Environment = var.env
    Project = var.ProjectName
  }
}
provider "aws" {
  region = local.current_region
}

#
module "VPC" {
  source = "../Modules/VPC"
  region = local.current_region
  cidr_block =var.cidr_block
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  # Tags
  default_tags = local.default_tags
  env = var.env
  vpc_tag = var.vpc_tag
  igw_tag = var.igw_tag
  public_subnet_tag = var.public_subnet_tag
  private_subnet_tag = var.private_subnet_tag
  public_RT_tag = var.public_RT_tag
  private_RT_tag = var.private_RT_tag

}

module "SG" {
  source = "../Modules/SG"
  vpc_id = module.VPC.MyVPC
  #tags
  default_tags = local.default_tags
  ec2_practice_SGtag = var.ec2_practice_SGtag
}

module "EC2" {
  source = "../Modules/EC2"
  ami = lookup(var.ami, var.select_ami, "ami-0606dd43116f5ed57")
  instance_type = var.instance_type
  ec2_practice_subnet = module.VPC.ec2_practice_subnet[0]
  ec2_practice_SG = module.SG.ec2_practice_SG
  key_name = var.key_name
  #tags
  default_tags = local.default_tags
  ec2_practice_tag = var.ec2_practice_tag
}