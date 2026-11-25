
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

# 配置VPC、子网和安全组规则
locals {
  sg_rules = [
    {
      range        = "8000-9000",
      dest_cidr_ip = "222.71.48.90/32"
      protocol     = "tcp"
      direction    = "ingress"
    },
  ]
}

module "vpc" {
  source             = "./vpc"
  vpc_name_prefix    = var.vpc_name
  subnet_name_prefix = var.subnet_name
  cidr               = var.cidr
  sg_rules           = local.sg_rules
}

# 创建云主机和弹性IP并绑定
module "ecs" {
  source               = "./ecs"
  ecs_count            = var.instance_count
  instance_name_prefix = var.instance_name
  display_name_prefix  = var.instance_name
  flavor_name          = var.flavor_name
  system_disk_type     = var.system_disk_type
  system_disk_size     = var.system_disk_size
  image_id             = var.image_id
  bandwidth            = var.bandwidth
  vpc_ids              = module.vpc.vpc_id
  subnet_ids           = module.vpc.subnet_id
  passwords            = local.passwords
}

# 输出主机信息
output "ecs_eip" {
  value = [
    for idx, e in module.ecs.ecs_list : {
      ecs_id      = module.ecs.ecs_list[idx].id
      ecs_name    = module.ecs.ecs_list[idx].display_name
      fixed_ip    = module.ecs.ecs_list[idx].fixed_ip
      eip_address = module.ecs.ecs_list[idx].eip_address
      password    = local.passwords[idx]
    }
  ]
}

locals {
  seed_list = [for i in range(var.instance_count) : "${var.password_seed}-${i}"]
  passwords = [
    for seed in local.seed_list :
    format(
      "%s%s%s",
      substr(replace(upper(sha256(seed)), "/[^A-Za-z0-9]/", ""), 0, 5),
      "A@a",
      substr(replace(lower(sha256(seed)), "/[^A-Za-z0-9]/", ""), 5, 5),
    )
  ]
}
