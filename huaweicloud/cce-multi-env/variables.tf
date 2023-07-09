#variable "region" {
#  type = string
#}

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}


variable "env_name" {
  type = string
}

variable "region" {
  type = string
}

variable "ccevpc_name" {
  type = string
}

variable "ccesubnet_name" {
  type = string
}

variable "ccesubnet_cidr" {
  type = string
}

variable "ccesubnet_gateway" {
  type = string
}

