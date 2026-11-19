
# create vpc
resource "ctyun_vpc" "vpc_test_demo" {
  name        = "vpc-for-ecs"
  cidr        = "192.168.0.0/16"
  description = "terraform_demo"
  enable_ipv6 = true
}
 
# create subnet
resource "ctyun_subnet" "subnet_test_demo" {
  vpc_id      = ctyun_vpc.vpc_test_demo.id
  name        = "subnet-for-ecs"
  cidr        = "192.168.1.0/24"
  description = "terraform_demo"
  dns = [
    "114.114.114.114",
    "8.8.8.8"
  ]
  enable_ipv6 = true
}
