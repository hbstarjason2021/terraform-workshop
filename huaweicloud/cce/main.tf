resource "huaweicloud_vpc" "ccevpc" {
  name = var.vpc_name
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

data "huaweicloud_availability_zones" "myaz" {}


## https://support.huaweicloud.com/usermanual-terraform/terraform_0015.html
## https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/cce_cluster

resource "huaweicloud_cce_cluster" "mycce" {
  name                   = var.cce_cluster_name
  flavor_id              = var.cce_cluster_flavor
  ## charging_mode          = var.cce_cluster_charging_mode   ## postPaid
  cluster_type           = var.cce_cluster_type
  cluster_version        = var.cce_cluster_version
  vpc_id                 = huaweicloud_vpc.ccevpc.id
  subnet_id              = huaweicloud_vpc_subnet.mysubnet.id
  container_network_type = "overlay_l2"
  eip                    = huaweicloud_vpc_eip.myeip.address
}



resource "local_file" "kube_config" {
            content = huaweicloud_cce_cluster.mycce.kube_config_raw
            filename = " ~/.kube/config"
}
