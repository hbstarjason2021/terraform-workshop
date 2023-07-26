
#### https://github.com/ucloud/terraform-provider-ucloud/tree/master/examples/vpc

#### https://github.com/terraform-ucloud-modules/terraform-ucloud-uhost-instance

#### https://docs.ucloud.cn/terraform/quickstart

#### https://docs.ucloud.cn/api/summary/regionlist

# export UCLOUD_PUBLIC_KEY="123"
# export UCLOUD_PRIVATE_KEY="123456"

provider "ucloud" {
  region = var.region
}

provider "ucloud" {
  alias  = "shanghai"
  region = var.peer_region
}

resource "ucloud_vpc" "vpc-bj" {
  name        = "tf-example-vpc-01"
  tag         = "tf-example"
  cidr_blocks = ["192.168.0.0/16"]
}

resource "ucloud_vpc" "vpc-sh" {
  provider    = ucloud.shanghai
  name        = "tf-example-vpc-02"
  tag         = "tf-example"
  cidr_blocks = ["10.10.0.0/16"]
}



/*
resource "ucloud_udpn_connection" "default" {
  peer_region = var.peer_region
}

resource "ucloud_vpc_peering_connection" "connection" {
  depends_on  = [ucloud_udpn_connection.default]
  vpc_id      = ucloud_vpc.foo.id
  peer_vpc_id = ucloud_vpc.bar.id
  peer_region = var.peer_region
}
*/
