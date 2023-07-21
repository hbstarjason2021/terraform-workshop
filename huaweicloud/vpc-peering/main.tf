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

resource "huaweicloud_vpc" "vpc_c" {
  name = "vpc-c"
  cidr = "172.17.2.0/24"
}

resource "huaweicloud_vpc_subnet" "subnet_c" {
  name       = "subnet-c"
  cidr       = "172.17.2.0/24"
  gateway_ip = "172.17.2.1"
  vpc_id     = huaweicloud_vpc.vpc_c.id
}

resource "huaweicloud_vpc" "vpc_d" {
  name = "vpc-d"
  cidr = "172.17.3.0/24"
}

resource "huaweicloud_vpc_subnet" "subnet_d" {
  name       = "subnet-d"
  cidr       = "172.17.3.0/24"
  gateway_ip = "172.17.3.1"
  vpc_id     = huaweicloud_vpc.vpc_d.id
}

resource "huaweicloud_vpc_peering_connection" "peering_a_b" {
  name        = "peering-a-b"
  vpc_id      = huaweicloud_vpc.vpc_a.id
  peer_vpc_id = huaweicloud_vpc.vpc_b.id
}

resource "huaweicloud_vpc_route" "vpc_route_a_d" {
  vpc_id      = huaweicloud_vpc.vpc_a.id
  destination = huaweicloud_vpc_subnet.subnet_d.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_a_b.id
}

resource "huaweicloud_vpc_route" "vpc_route_b_a" {
  vpc_id      = huaweicloud_vpc.vpc_b.id
  destination = huaweicloud_vpc_subnet.subnet_a.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_a_b.id
}

resource "huaweicloud_vpc_peering_connection" "peering_b_c" {
  name        = "peering-b-c"
  vpc_id      = huaweicloud_vpc.vpc_b.id
  peer_vpc_id = huaweicloud_vpc.vpc_c.id
}

resource "huaweicloud_vpc_route" "vpc_route_b_d" {
  vpc_id      = huaweicloud_vpc.vpc_b.id
  destination = huaweicloud_vpc_subnet.subnet_d.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_b_c.id
}

resource "huaweicloud_vpc_route" "vpc_route_c_a" {
  vpc_id      = huaweicloud_vpc.vpc_c.id
  destination = huaweicloud_vpc_subnet.subnet_a.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_b_c.id
}

resource "huaweicloud_vpc_peering_connection" "peering_c_d" {
  name        = "peering-c-d"
  vpc_id      = huaweicloud_vpc.vpc_c.id
  peer_vpc_id = huaweicloud_vpc.vpc_d.id
}

resource "huaweicloud_vpc_route" "vpc_route_c_d" {
  vpc_id      = huaweicloud_vpc.vpc_c.id
  destination = huaweicloud_vpc_subnet.subnet_d.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_c_d.id
}

resource "huaweicloud_vpc_route" "vpc_route_d_a" {
  vpc_id      = huaweicloud_vpc.vpc_d.id
  destination = huaweicloud_vpc_subnet.subnet_a.cidr
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering_c_d.id
}

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
  cpu_core_count    = 1
  memory_size       = 2
}

data "huaweicloud_images_image" "centos" {
  name_regex   = "^CentOS 8.0"
  visibility   = "public"
  most_recent  = true
}

data "huaweicloud_availability_zones" "azs" {}

resource "huaweicloud_compute_instance" "ecs_a" {
  name                = "ecs-a"
  admin_pass          = "Huawei@123"
  image_id            = data.huaweicloud_images_image.centos.id
  flavor_id           = data.huaweicloud_compute_flavors.flavors.ids[0]
  security_group_ids  = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone   = data.huaweicloud_availability_zones.azs.names[0]

  network {
    uuid = huaweicloud_vpc_subnet.subnet_a.id
    fixed_ip_v4 = "172.17.0.10"
  }
}

resource "huaweicloud_compute_instance" "ecs_d" {
  name                = "ecs-d"
  admin_pass          = "Huawei@123"
  image_id            = data.huaweicloud_images_image.centos.id
  flavor_id           = data.huaweicloud_compute_flavors.flavors.ids[0]
  security_group_ids  = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone   = data.huaweicloud_availability_zones.azs.names[0]

  network {
    uuid = huaweicloud_vpc_subnet.subnet_d.id
    fixed_ip_v4 = "172.17.3.10"
  }
}
