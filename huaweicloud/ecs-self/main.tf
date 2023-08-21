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

resource "huaweicloud_compute_keypair" "mykeypair" {
  #name     = var.keypair_name
  name      = local.keypair_name
  #name     = "keypair-zhang"
  #key_file = "private_zhang.pem" 
  #key_file = var.private_key_path
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuvqz+PrUSUMk3zLBIJVBkNvpZbULg/T4qJ1TlHMhhobeJk9280U67prXAjgEoF7XVlNjUd/+xzMo23154wmy2obdvj0r091rjKIg2fRzUCjsjaTvb7Myumi7bG9Ktu8l7k9m3jeJJfELIgVFl3N2nUyq5bvd0iy/bVv3oc8SkUBHVARuOloRqXk5ps5as6vHGpB2vYfyhcoAJU0fSdw2GXlFeCMcn/J/sCWq+uLOLs6HYO8CLUtW55k2BMtZ4sOQ/POYmdJc1vTcfAGTRE0glxvd06uiSr36IDTDcYoJuXq5QEU5mpvIyf0vpiOAsHMzFWBz/qFD5oadu38JzEBPqOXjXvJvAiH+YfCj4yY7Luhfzn8yCXlB4+kuTBuySdox3ZXAi1sSwLDz+Ppg4LgMCjNPPwNtUuwCBwp2oIUsMGQeI5NNmpSSKTpvg/y+OlsPcL2PLNywcRBIogvYSR6cxsd7qaO+cD5gE11167am30C9neDdclhiz2qwR3A+V8CU= root@ecs-self"
 
}

resource "huaweicloud_compute_instance" "myinstance" {
  #name               = "ecs-self"
  name               = local.ecs_name
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  #security_groups   = ["default"]
  #security_group_ids = [huaweicloud_networking_secgroup.default.id]
  
  availability_zone  = data.huaweicloud_availability_zones.myaz.names[0]
  system_disk_type   = "SSD"
  key_pair          = huaweicloud_compute_keypair.mykeypair.name
  #admin_pass        = "Huawei123" 
  #admin_pass        = random_password.password.result
  
  # charging_mode = "prePaid"
  # period_unit   = "month"
  # period        = 1
  
  ## wget http://mirrors.myhuaweicloud.com/repo/mirrors_source.sh && sh mirrors_source.sh
  user_data = "#!/bin/bash\n wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash"


# 注意有坑：设置了user_data字段后，admin_pass字段将无效
# https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/examples/ecs/userdata/main.tf
  
  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }
}


resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "ecs_bandwidth"
    size        = 50
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.myeip.address
  instance_id = huaweicloud_compute_instance.myinstance.id
}


/*
resource "null_resource" "wait_for_init" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  

apt-get update -y
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/ali.sh | bash
sleep 15
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash
sleep 5
    EOF
  }

  depends_on = [huaweicloud_compute_instance.myinstance]
}
*/


output "slb_eip_address" {
  value = huaweicloud_vpc_eip.myeip.address

}


resource "null_resource" "provision" {
  depends_on = [huaweicloud_compute_eip_associate.associated]

  provisioner "remote-exec" {
    connection {
      user        = "root"
      private_key = file(var.private_key_path)
      host        = huaweicloud_vpc_eip.myeip.address
    }

    inline = [
      " wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/ali.sh | bash"
    ]
  }
}
