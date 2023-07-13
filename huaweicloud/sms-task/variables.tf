variable "vpc_name" {
  default = "vpc-source"
  #type = string
}

/*
variable "vpc_cidr" {
  #default = "172.16.0.0/16"
   type = string
}

variable "subnet_name" {
  #default = "subent-default"
   type = string
}

variable "subnet_cidr" {
  #default = "172.16.10.0/24"
   type = string
}

variable "subnet_gateway" {
  #default = "172.16.10.1"
   type = string
}

*/

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}
