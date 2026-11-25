terraform {
  required_providers {
    ctyun = {
      source  = "ctyun-it/ctyun"
      ### version = "2.1.0"
    }
  }
}

locals {
  vpc_count = length(var.vpc_ids)
}

# 创建绑定EIP的云主机
resource "ctyun_ecs" "ecs" {
  count            = var.ecs_count
  instance_name    = "${var.instance_name_prefix}-${count.index + 1}"
  display_name     = "${var.display_name_prefix}-${count.index + 1}"
  flavor_name      = var.flavor_name
  image_id         = var.image_id
  system_disk_type = var.system_disk_type
  system_disk_size = var.system_disk_size
  vpc_id           = var.vpc_ids[count.index % local.vpc_count]
  subnet_id        = var.subnet_ids[count.index % local.vpc_count]
  status           = var.status
  cycle_type       = "on_demand"
  bandwidth        = var.bandwidth
  password         = var.passwords[count.index]
}

output "ecs_list" {
  value = ctyun_ecs.ecs
}
