variable "number" {
  default = "3"
}


resource "huaweicloud_compute_instance" "multi_instance" {
  name            = "ecs-multi-${count.index}"
  count           = var.number
  image_id        = data.huaweicloud_images_image.myimage.id
  flavor_id       = data.huaweicloud_compute_flavors.myflavor.ids[0]
  #flavor_id       = "s6.xlarge.2"
  security_groups = ["Sys-FullAccess"]
  #security_group_ids = data.huaweicloud_networking_secgroup.mysecgroup.id

  availability_zone = data.huaweicloud_availability_zones.myaz.names[3]
  system_disk_type  = "GPSSD"
   admin_pass         = "Huawei@1234" 
  #key_pair              = data.huaweicloud_kps_keypairs.mykeypair.name
  #charging_mode         = "prePaid"
  #period_unit           = "month"
  #period                = 1
  #enterprise_project_id = "XXXXXXXXXXXXXXXXXXXXXXX"

  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }
}

##############################################################

resource "huaweicloud_evs_volume" "myvol" {
  count             = var.number
  name              = "volume_${count.index}"
  availability_zone = data.huaweicloud_availability_zones.myaz.names[3]
  volume_type       = "SAS"
  size              = 500
}

resource "huaweicloud_compute_volume_attach" "attachments" {
  count       = var.number
  instance_id = huaweicloud_compute_instance.multi_instance[count.index].id
  volume_id   = element(huaweicloud_evs_volume.myvol[*].id, count.index)
}

output "volume-devices" {
  value = huaweicloud_compute_volume_attach.attachments[*].device
}

##################################################################


resource "huaweicloud_vpc_eip" "multi_eip" {
  count = var.number
  publicip {
    type = "5_bgp"

  }
  bandwidth {

    name        = "multi_bandwidth"
    size        = 10
    share_type  = "PER"
    charge_mode = "traffic"
  }
}


resource "huaweicloud_compute_eip_associate" "multi_associated" {
  count       = var.number
  public_ip   = huaweicloud_vpc_eip.multi_eip[count.index].address
  instance_id = element(huaweicloud_vpc_eip.multi_eip[*].id, count.index)
}

