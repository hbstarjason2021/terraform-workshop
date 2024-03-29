
#variable "hw_access_key" {
#    #type = "string"
#}
#variable "hw_secret_key" {
#    #type = "string"
#}

#variable "hw_region" {
#  type    = string
#  default = "cn-north-4"
#}

variable "keypair_name" {
  description = "Keypair name"
  default = "keypair-zhang369"
}

variable "vpc_name" {
  default = "vpc-basic"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_name" {
  default = "subent-basic"
}

variable "subnet_cidr" {
  default = "172.16.10.0/24"
}

variable "subnet_gateway" {
  default = "172.16.10.1"
}

variable "secgroup_name" {
  default = "secgroup-basic"
   #type = string
}


variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}
