
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
