resource "huaweicloud_vpc" "ccevpc" {
  #name = "ccevpc-${var.env_name}"
  name = "ccevpc"
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "mysubnet" {
  name       = var.subnet_name
  cidr       = var.subnet_cidr
  gateway_ip = var.subnet_gateway

  # dns is required for cce node installing
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.ccevpc.id
}

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = var.bandwidth_name
    size        = 8
    share_type  = "PER"
    charge_mode = "traffic"
  }
}
