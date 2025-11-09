variable "ami" {
  description = "desired ami"
}

variable "instance_type" {
  description = "desired isntance type"
}

variable "ec2_practice_SG" {
  description = "ec2_practice SG"
  type = string
}

variable "ec2_practice_subnet" {
  description = "ec2_practice subnet"
}

variable "key_name" {
  description = "Key needed to access ec2_practice"
}

# Tags
variable "default_tags" {
  description = "local tags"
}

variable "ec2_practice_tag" {
  description = "ec2_practice name tag"
}