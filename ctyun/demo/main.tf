
terraform {
  required_providers {
    ctyun = {
      source = "ctyun-it/ctyun"
      ##version = "2.1.1"
    }
  }
}


### https://registry.terraform.io/providers/ctyun-it/ctyun/2.1.1/docs
provider "ctyun" {
  ak        = "ak"
  sk        = "sk"
  region_id = "200000001852"
  az_name   = "cn-huabei2-tj1A-public-ctcloud"
  ### env       = "test"
}


# create vpc
resource "ctyun_vpc" "vpc_test_demo" {
  name        = "vpc-for-demo"
  cidr        = "192.168.0.0/16"
  description = "terraform_demo"
  enable_ipv6 = true
}
 
# create subnet
resource "ctyun_subnet" "subnet_test_demo" {
  vpc_id      = ctyun_vpc.vpc_test_demo.id
  name        = "subnet-for-demo"
  cidr        = "192.168.1.0/24"
  description = "terraform_demo"
  dns = [
    "114.114.114.114",
    "8.8.8.8"
  ]
  enable_ipv6 = true
}
