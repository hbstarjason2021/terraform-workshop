variable "ecs_name" {
  default = "ecs-source-new"
}

variable "vpc_name" {
  default = "vpc-source-new"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "subnet_name" {
  default = "subnet-source-new"
}

variable "subnet_cidr" {
  default = "192.168.0.0/24"
}

variable "subnet_gateway" {
  default = "192.168.0.1"
}

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}
