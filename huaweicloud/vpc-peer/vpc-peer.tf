
resource "huaweicloud_vpc" "vpc_a" {
  name = "vpc-a"
  cidr = "172.17.0.0/24"
}

resource "huaweicloud_vpc_subnet" "subnet_a" {
  name       = "subnet-a"
  cidr       = "172.17.0.0/24"
  gateway_ip = "172.17.0.1"
  vpc_id     = huaweicloud_vpc.vpc_a.id
}

resource "huaweicloud_vpc" "vpc_b" {
  name = "vpc-b"
  cidr = "172.17.1.0/24"
}

resource "huaweicloud_vpc_subnet" "subnet_b" {
  name       = "subnet-b"
  cidr       = "172.17.1.0/24"
  gateway_ip = "172.17.1.1"
  vpc_id     = huaweicloud_vpc.vpc_b.id
}

###################################################

resource "huaweicloud_vpc_peering_connection" "peering_a_b" {
  name        = "peering-a-b"
  vpc_id      = huaweicloud_vpc.vpc_a.id
  peer_vpc_id = huaweicloud_vpc.vpc_b.id
}


resource "huaweicloud_vpc_route" "vpc_route_a_b" {
  vpc_id      = huaweicloud_vpc.vpc_a.id
  destination = huaweicloud_vpc_subnet.subnet_b.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_a_b.id
}

resource "huaweicloud_vpc_route" "vpc_route_b_a" {
  vpc_id      = huaweicloud_vpc.vpc_b.id
  destination = huaweicloud_vpc_subnet.subnet_a.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_a_b.id
}


###################################################

resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = "secgroup-peering"
}


# 安全组规则-开放22端口
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}



data "huaweicloud_compute_flavors" "flavors" {
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}

data "huaweicloud_images_image" "ubuntu" {
  #name_regex   = "^Ubuntu 20.04"
  name        = "Ubuntu 20.04 server 64bit"
  visibility   = "public"
  most_recent  = true
}

data "huaweicloud_availability_zones" "azs" {}

resource "huaweicloud_compute_instance" "ecs_a" {
  name                = "ecs-a"
  admin_pass          = "Huawei@123"
  image_id            = data.huaweicloud_images_image.ubuntu.id
  flavor_id           = data.huaweicloud_compute_flavors.flavors.ids[0]
  security_group_ids  = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone   = data.huaweicloud_availability_zones.azs.names[0]

  network {
    uuid = huaweicloud_vpc_subnet.subnet_a.id
    fixed_ip_v4 = "172.17.0.10"
  }
}

resource "huaweicloud_compute_instance" "ecs_b" {
  name                = "ecs-b"
  admin_pass          = "Huawei@123"
  image_id            = data.huaweicloud_images_image.ubuntu.id
  flavor_id           = data.huaweicloud_compute_flavors.flavors.ids[0]
  security_group_ids  = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone   = data.huaweicloud_availability_zones.azs.names[0]

  network {
    uuid = huaweicloud_vpc_subnet.subnet_b.id
    fixed_ip_v4 = "172.17.1.10"
  }
}

###########################################

/*
resource "null_resource" "provision" {
  #depends_on = [huaweicloud_compute_eip_associate.associated]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      #private_key = file(var.private_key_path)
      password    = "Huawei@123"
      #host        = huaweicloud_vpc_eip.myeip.address
      host        = "172.17.0.10"
    }

    inline = [
      " hostname && df -h && ping -c 5 172.17.1.10 "
    ]
  }
}
*/
