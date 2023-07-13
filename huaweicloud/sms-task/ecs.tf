
### 通用计算型 s6.small.1 
### Huawei Cloud EulerOS 2.0 标准版 64位| 公共镜像

### 系统盘：保持默认，通用型SSD，40G
### vpc-source
### subnet-source
### sg-source
### 弹性公网IP：现在购买
### 线路：静态BGP
### 公网带宽：按流量计费带宽大小：100
### 云服务器名称：输入"ecs-source"
### 输入密码“Huawei@1234”

data "huaweicloud_availability_zones" "myaz" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 1
  memory_size       = 1
}


/*
data "huaweicloud_images_image" "myimage" {
  name        = "Huawei Cloud EulerOS 2.0 标准版 64位"
  most_recent = true
}

output "image_id" {
  value = data.huaweicloud_images_image.myimage.id
}
*/


data "huaweicloud_vpc" "myvpc" {
  # name = var.vpc_name
   name = "vpc-source"
}

output "vpc_id" {
  value = data.huaweicloud_vpc.myvpc.id
}

data "huaweicloud_vpc_subnet" "mysubnet" {
  #name = var.subnet_name
  name = "subnet-source"
}

output "subne_id" {
  value = data.huaweicloud_vpc_subnet.mysubnet.id
}

data "huaweicloud_networking_secgroup" "mysecgroup" {
  name = "sg-source"
}

output "secgroup_id" {
  value = data.huaweicloud_networking_secgroup.mysecgroup.id
}


################################################

resource "huaweicloud_compute_instance" "myinstance" {
  name               = "ecs-source"
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  #security_groups   = data.huaweicloud_networking_secgroup.myinstance.id
  security_group_ids = data.huaweicloud_networking_secgroup.myinstance.id
  
  availability_zone  = data.huaweicloud_availability_zones.myaz.names[0]
  system_disk_type   = "SSD"
  admin_pass        = "Huawei@1234" 

  
  network {
    uuid = data.huaweicloud_vpc_subnet.mysubnet.id
  }
}


########################################################
/*

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "mybandwidth"
    size        = 100
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.myeip.address
  instance_id = huaweicloud_compute_instance.myinstance.id
}

*/
