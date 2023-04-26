
resource "huaweicloud_vpc_bandwidth" "bandwidth_1" {
  name = var.bandwidth_name
  size = 5
}

resource "huaweicloud_vpc_eip" "eip" {
  count = length(var.instances)
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    share_type = "WHOLE"
    id         = huaweicloud_vpc_bandwidth.bandwidth_1.id
  }
}


resource "huaweicloud_compute_eip_associate" "associated" {
  count = length(var.instances)
  public_ip   = huaweicloud_vpc_eip.eip.*.address[count.index]
  instance_id = var.instances[count.index]
}
