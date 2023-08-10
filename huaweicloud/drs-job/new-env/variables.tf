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


variable "rds_password" {
  default = "Zh9NTF8919w"
}


variable "vpc_name" {
  default = "vpc-basic"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_name" {
  default = "subnet-source"
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
