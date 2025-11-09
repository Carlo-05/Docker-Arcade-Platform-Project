# VPC
variable "region" {
  description = "desired region"
  type = map(string)
  default = {
    "west1" = "us-west-1"
    "west2" = "us-west-2"
  }
}

variable "select_region" {
  description = "choose between wes1 and west2"
  type = string
  default = "west2"
}

variable "cidr_block" {
  description = "vpc cidr"
}

variable "public_subnet_count" {
  description = "how many public subnet"
  type = number
  default = 0
}
variable "private_subnet_count" {
  description = "how many private subnet"
  type = number
  default = 0
}


#EC2
variable "ami" {
  description = "desired ami"
  type = map(string)
  default = {
    "ubuntu" = "ami-0606dd43116f5ed57"
    "linux2" = "ami-0520f976ad2e6300c"
  }
}

variable "select_ami" {
    description = "choose between ubuntu and linux2"
    default = "ubuntu"
}

variable "instance_type" {
  description = "desired instance type"
}

variable "key_name" {
  description = "key pair"
}
#tags
# local tag
variable "ProjectName" {
  description = "project name"
}
variable "env" {
  description = "environment name"
}
#vpc tag
variable "vpc_tag" {
  description = "vpc name tag"
}

variable "igw_tag" {
  description = "igw name tag"
}
variable "public_subnet_tag" {
  description = "public subnet name tag"
}

variable "private_subnet_tag" {
  description = "private subnet name tag"
}

variable "public_RT_tag" {
  description = "public RT name tag"
}
variable "private_RT_tag" {
  description = "private RT name tag"
}

#SG tag
variable "ec2_practice_SGtag" {
  description = "ec2 sg name"
}
#ec2 tag
variable "ec2_practice_tag" {
  description = "ec2 instance name"
}