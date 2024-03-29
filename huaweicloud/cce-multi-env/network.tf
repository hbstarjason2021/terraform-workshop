resource "huaweicloud_vpc" "ccevpc" {
  name = "ccevpc-${var.env_name}"
  cidr = var.ccevpc_cidr
}

resource "huaweicloud_vpc_subnet" "ccesubnet" {
  name       = "ccesubnet-${var.env_name}"
  cidr       = var.ccesubnet_cidr
  gateway_ip = var.ccesubnet_gateway

  # dns is required for cce node installing
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.ccevpc.id
}
