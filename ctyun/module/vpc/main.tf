terraform {
  required_providers {
    ctyun = {
      source  = "ctyun-it/ctyun"
      ## version = "2.1.0"
    }
  }
}

locals {
  vpc_count = length(var.cidr)
}

# 创建vpc
resource "ctyun_vpc" "vpc" {
  count = local.vpc_count
  name  = "${var.vpc_name_prefix}-${count.index + 1}"
  cidr  = var.cidr[count.index]
}

# 在vpc下创建子网
resource "ctyun_subnet" "subnet" {
  count  = local.vpc_count
  vpc_id = ctyun_vpc.vpc[count.index].id
  name   = "${var.subnet_name_prefix}-${count.index + 1}"
  cidr   = var.cidr[count.index]
  dns = [
    "114.114.114.114",
    "8.8.8.8",
  ]
}

# 查询安全组
data "ctyun_security_groups" "security_group" {
  count  = local.vpc_count
  vpc_id = ctyun_vpc.vpc[count.index].id
}

locals {
  security_group_ids = [for idx in range(local.vpc_count) : data.ctyun_security_groups.security_group[idx].security_groups[0].security_group_id]
}

resource "ctyun_security_group_rule" "security_group_rule" {
  # 双重循环：每个安全组 × 每个规则
  for_each = {
    for index, pair in setproduct(local.security_group_ids, var.sg_rules) :
    "rule_${index}" => {
      security_group_id = pair[0]
      rule              = pair[1]
    }
  }

  security_group_id = each.value.security_group_id
  direction         = each.value.rule.direction
  protocol          = each.value.rule.protocol
  dest_cidr_ip      = each.value.rule.dest_cidr_ip
  range             = each.value.rule.range

  action     = "accept"
  priority   = 1
  ether_type = "ipv4"
}

output "vpc_id" {
  value = ctyun_vpc.vpc[*].id
}

output "subnet_id" {
  value = ctyun_subnet.subnet[*].id
}
