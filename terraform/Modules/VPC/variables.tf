variable "region" {
  type = string
  description = "desired region"
}

variable "cidr_block" {
    description = "desired cidr block"  
}

variable "public_subnet_count" {
  type = number
  default = 0
  description = "how many public subnet you need?"
}

variable "private_subnet_count" {
  type = number
  default = 0
  description = "how many private subnet you need?"
}

# Tags
variable "default_tags" {
  description = "local tags"
}
variable "env" {
  description = "environment name"
}
variable "vpc_tag" {
  description = "vpc name tag"
}

variable "igw_tag" {
  description = "internet gateway name tag"
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