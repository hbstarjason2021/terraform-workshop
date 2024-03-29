
data "huaweicloud_availability_zones" "myaz" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 8
  memory_size       = 16
}


data "huaweicloud_images_image" "myimage" {
  name        = "Ubuntu 20.04 server 64bit"
  most_recent = true
}

resource "huaweicloud_vpc" "myvpc" {
  #name = var.vpc_name
  name = local.vpc_name
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "mysubnet" {
  #name       = var.subnet_name
  name       = local.subnet_name
  cidr       = var.subnet_cidr
  gateway_ip = var.subnet_gateway

  # dns is required for cce node installing
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.myvpc.id
}

/*
resource "huaweicloud_compute_keypair" "mykeypair" {
  name     = var.keypair_name
  #name      = local.keypair_name
  #name     = "keypair-zhang"
  #key_file = "private_zhang.pem" 
  #key_file = var.private_key_path
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuvqz+PrUSUMk3zLBIJVBkNvpZbULg/T4qJ1TlHMhhobeJk9280U67prXAjgEoF7XVlNjUd/+xzMo23154wmy2obdvj0r091rjKIg2fRzUCjsjaTvb7Myumi7bG9Ktu8l7k9m3jeJJfELIgVFl3N2nUyq5bvd0iy/bVv3oc8SkUBHVARuOloRqXk5ps5as6vHGpB2vYfyhcoAJU0fSdw2GXlFeCMcn/J/sCWq+uLOLs6HYO8CLUtW55k2BMtZ4sOQ/POYmdJc1vTcfAGTRE0glxvd06uiSr36IDTDcYoJuXq5QEU5mpvIyf0vpiOAsHMzFWBz/qFD5oadu38JzEBPqOXjXvJvAiH+YfCj4yY7Luhfzn8yCXlB4+kuTBuySdox3ZXAi1sSwLDz+Ppg4LgMCjNPPwNtUuwCBwp2oIUsMGQeI5NNmpSSKTpvg/y+OlsPcL2PLNywcRBIogvYSR6cxsd7qaO+cD5gE11167am30C9neDdclhiz2qwR3A+V8CU= root@ecs-self" 
}

data "huaweicloud_kps_keypairs" "mykeypair" {
  name = "keypair_name"
}
*/


resource "huaweicloud_compute_instance" "multi_instance" {
  name            = "ecs-multi-${count.index}"
  count           = var.number
  image_id        = data.huaweicloud_images_image.myimage.id
  #flavor_id       = data.huaweicloud_compute_flavors.myflavor.ids[0]
  flavor_id        = "c7n.2xlarge.2"
  #security_groups = [var.secgroup_name]
  #security_group_ids = data.huaweicloud_networking_secgroup.mysecgroup.id

  availability_zone = data.huaweicloud_availability_zones.myaz.names[3]
  system_disk_type  = "GPSSD"
  admin_pass        = "Huawei@1234" 
  #key_pair          = data.huaweicloud_kps_keypairs.mykeypair.name
  #key_pair          = huaweicloud_compute_keypair.mykeypair.name

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
  size              = 200
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

    name        = "multi_bandwidth-${count.index}"
    size        = 50
    share_type  = "PER"
    charge_mode = "traffic"
  }
}


resource "huaweicloud_compute_eip_associate" "multi_associated" {
  count       = var.number
  public_ip   = huaweicloud_vpc_eip.multi_eip[count.index].address
  instance_id = element(huaweicloud_compute_instance.multi_instance[*].id, count.index)
}


output "public_ip" {
  value = huaweicloud_vpc_eip.multi_eip[*].address
}

output "instance_id" {
  value = huaweicloud_compute_instance.multi_instance[*].id
}
