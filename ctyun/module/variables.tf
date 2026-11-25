
variable "az_name" {
  type        = string
  default     = "cn-huabei2-tj1A-public-ctcloud"
  description = "可用区名称"
}

variable "vpc_name" {
  type        = string
  default     = "test-vpc"
  description = "VPC名称"
}

variable "subnet_name" {
  type        = string
  default     = "test-subnet"
  description = "子网名称"
}

variable "cidr" {
  type        = list(string)
  default     = ["172.18.1.0/24", "172.18.2.0/24"]
  description = "CIDR"
}

variable "instance_name" {
  type        = string
  default     = "test-ecs"
  description = "云主机名称"
}

variable "instance_count" {
  type        = number
  default     = 4
  description = "云主机数量"
}

variable "image_id" {
  type        = string
  default     = "f9415853-b07d-4dd8-afb7-f48e10de151e"
  description = "镜像ID"
}

variable "flavor_name" {
  type        = string
  default     = "c7.xlarge.2"
  description = "规格名称"
}

variable "system_disk_type" {
  type        = string
  default     = "SAS"
  description = "系统盘类型"
}

variable "system_disk_size" {
  type        = number
  default     = 40
  description = "系统盘大小"
}

variable "bandwidth" {
  type        = number
  default     = 10
  description = "公网带宽"
}

variable "password_seed" {
  type        = string
  default     = "random_password_seed"
  description = "随机密码种子"
}
