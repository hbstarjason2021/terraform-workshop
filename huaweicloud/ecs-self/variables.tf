
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
}


variable "keypair_name" {
  description = "Keypair name"
  default = "keypair-zhang"
}

variable "private_key_path" {
  description = "The relative path of the private key"
  default = "private_zhang.pem"
}

#variable "hw_region" {
#  type    = string
#  default = "cn-north-4"
#}

variable "ecs_name" {
  default = "ecs-self"
}

variable "vpc_name" {
  default = "vpc-self"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_name" {
  default = "subent-self"
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
