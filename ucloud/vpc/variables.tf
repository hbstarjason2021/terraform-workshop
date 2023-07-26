variable "region" {
  default     = "cn-bj2"
}

variable "peer_region" {
  default     = "cn-sh2"
}

/*
resource "ucloud_vpc" "foo" {
  name        = "tf-example-vpc-01"
  tag         = "tf-example"
  cidr_blocks = ["192.168.0.0/16"]
}

resource "ucloud_vpc" "bar" {
  provider    = ucloud.shanghai
  name        = "tf-example-vpc-02"
  tag         = "tf-example"
  cidr_blocks = ["10.10.0.0/16"]
}

*/
