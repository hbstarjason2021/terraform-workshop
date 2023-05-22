data "huaweicloud_availability_zones" "myaz" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 4
  memory_size       = 8
}

#data "huaweicloud_vpc_subnet" "mynet" {
#  name = "subnet-default"
#}

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


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!@"
  min_numeric      = 1
  min_lower        = 1
  min_special      = 1
}

resource "huaweicloud_compute_instance" "myinstance" {
  name               = "basic"
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  #security_groups   = ["default"]
  #security_group_ids = [huaweicloud_networking_secgroup.default.id]
  
  availability_zone  = data.huaweicloud_availability_zones.myaz.names[0]
  system_disk_type   = "SSD"
  admin_pass        = "Huawei123" 
  #admin_pass        = random_password.password.result
  
  # charging_mode = "prePaid"
  # period_unit   = "month"
  # period        = 1
  
  ## wget http://mirrors.myhuaweicloud.com/repo/mirrors_source.sh && sh mirrors_source.sh
  ## user_data = "#!/bin/bash\napt-get update -y && wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash"
  user_data         = <<-EOF
#!/bin/bash
echo Huawei@123 | passwd root --stdin > /dev/null 2>&1
apt-get update -y
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/ali.sh | bash
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash
EOF

# 注意有坑：设置了user_data字段后，admin_pass字段将无效
  
  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }
}

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "mybandwidth"
    size        = 50
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.myeip.address
  instance_id = huaweicloud_compute_instance.myinstance.id
}


resource "huaweicloud_evs_volume" "myvolume" {
  name              = "myvolume"
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  volume_type       = "SAS"
  size              = 10
}

resource "huaweicloud_compute_volume_attach" "attached" {
  instance_id = huaweicloud_compute_instance.myinstance.id
  volume_id   = huaweicloud_evs_volume.myvolume.id
}
