
#variable "hw_access_key" {
#    #type = "string"
#}
#variable "hw_secret_key" {
#    #type = "string"
#}

locals {
  timestamp    = formatdate("YYYYMMDDhhmmss", timestamp())
  keypair_name = "keypair-zhang-${local.timestamp}"
  ecs_name     = "ecs-self-${local.timestamp}"
  vpc_name     = "vpc-self-${local.timestamp}"
  subnet_name  = "subnet_name-${local.timestamp}"
}


variable "private_key_path" {
  description = "The relative path of the private key"
  default = "private_zhang.pem"
}


#variable "hw_region" {
#  type    = string
#  default = "cn-north-4"
#}


variable "keypair_name" {
  description = "Keypair name"
  default = "keypair-zhang369"
}

/*
variable "ecs_name" {
  default = "ecs-self"
}

variable "vpc_name" {
  default = "vpc-self-${local.timestamp}"
}

variable "subnet_name" {
  default = "subent-self-${local.timestamp}"
}
*/

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_cidr" {
  default = "172.16.10.0/24"
}

variable "subnet_gateway" {
  default = "172.16.10.1"
}

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}
