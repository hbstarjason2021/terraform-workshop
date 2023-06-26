
#########################

 resource "huaweicloud_vpc" "myvpc" {
  name = "vpc-turbo"
  cidr = "192.168.0.0/16"
}

resource "huaweicloud_vpc_subnet" "mysubnet" {
  name       = "subnet-turbo"
  cidr       = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"

  //dns is required for cce node installing
  primary_dns   = "100.125.1.250"
  secondary_dns = "100.125.21.250"
  vpc_id        = huaweicloud_vpc.myvpc.id
}

resource "huaweicloud_vpc_subnet" "eni_test_1" {
  name          = "subnet-eni-1"
  cidr          = "192.168.2.0/24"
  gateway_ip    = "192.168.2.1"
  vpc_id        = huaweicloud_vpc.myvpc.id
}

resource "huaweicloud_vpc_subnet" "eni_test_2" {
  name          = "subnet-eni-2"
  cidr          = "192.168.3.0/24"
  gateway_ip    = "192.168.3.1"
  vpc_id        = huaweicloud_vpc.myvpc.id
}

##############################

resource "huaweicloud_cce_cluster" "turbo" {
  name                   = "turbo"
  flavor_id              = "cce.s1.small"
  vpc_id                 = huaweicloud_vpc.myvpc.id
  subnet_id              = huaweicloud_vpc_subnet.mysubnet.id
  container_network_type = "eni"
  eni_subnet_id          = join(",", [
    huaweicloud_vpc_subnet.eni_test_1.ipv4_subnet_id,
    huaweicloud_vpc_subnet.eni_test_2.ipv4_subnet_id,
  ])
}


################################ node_pool.tf

resource "huaweicloud_compute_keypair" "mykeypair" {
  name = "turbokey"
}

resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.turbo.id
  name                     = "myccepool"
  os                       = "EulerOS 2.9"
  initial_node_count       = 2
  flavor_id                = "c7.xlarge.2"
  # availability_zone        = var.availability_zone
  key_pair                 = huaweicloud_compute_keypair.mykeypair.name
  scall_enable             = true
  min_node_count           = 1
  max_node_count           = 10
  scale_down_cooldown_time = 100
  priority                 = 1
  type                     = "vm"

  root_volume {
    size       = 40
    volumetype = "SAS"
  }
  data_volumes {
    size       = 100
    volumetype = "SAS"
  }
}
