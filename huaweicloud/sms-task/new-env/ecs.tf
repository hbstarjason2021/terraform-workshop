data "huaweicloud_availability_zones" "myaz" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 1
  memory_size       = 1
}


data "huaweicloud_images_image" "myimage" {
  name        = "Ubuntu 20.04 server 64bit"
  most_recent = true
}

resource "huaweicloud_vpc" "myvpc" {
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
  vpc_id        = huaweicloud_vpc.myvpc.id
}

resource "huaweicloud_compute_instance" "myinstance" {
  name               = "ecs-source"
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  #security_groups   = ["default"]
  security_group_ids = [huaweicloud_networking_secgroup.secgroup.id]
  
  availability_zone  = data.huaweicloud_availability_zones.myaz.names[0]
  system_disk_type   = "GPSSD"
  admin_pass         = "Huawei@1234" 
  #admin_pass        = random_password.password.result
  #power_action       = "FORCE-OFF"   ############ON, OFF, REBOOT, FORCE-OFF and FORCE-REBOOT

  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }


}


###########################################################################

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_sbgp"
    ### 5_bgp (dynamic BGP) 
    ### 5_sbgp (static BGP)
    ### the default value is 5_bgp
  }
  bandwidth {
    name        = "mybandwidth"
    size        = 10
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.myeip.address
  instance_id = huaweicloud_compute_instance.myinstance.id
}


output "slb_eip_address" {
  value = huaweicloud_vpc_eip.myeip.address

}

###############################################################

/*
resource "null_resource" "provision" {
  depends_on = [huaweicloud_compute_eip_associate.associated]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      #private_key = file(var.private_key_path)
      password    = "Huawei@1234"
      host        = huaweicloud_vpc_eip.myeip.address
    }

    inline = [
      "bash install_agent.sh"
    ]
  }
}
*/
