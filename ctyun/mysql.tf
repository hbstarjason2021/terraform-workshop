terraform {
  required_providers {
    ctyun = {
      source  = "ctyun-it/ctyun"
      ### version = "1.2.0"
    }
  }
}
 
# 支持配置资源池、可用区和企业项目，若不配置资源池，则会使用页面选定的资源池
# ak/sk无需配置，会自动获取当前账号的ak/sk 
provider "ctyun" {
  region_id = "bb9fdb42056f11eda1610242ac110002"
  az_name = "cn-huadong1-jsnj1A-public-ctcloud"
}
 
 
# 创建vpc
resource "ctyun_vpc" "vpc_test" {
  name        = "vpc-for-mysql"
  cidr        = "192.168.0.0/16"
  description = "terraform测试使用"
}
 
# 在vpc下创建子网
resource "ctyun_subnet" "subnet_test" {
  vpc_id      = ctyun_vpc.vpc_test.id
  name        = "subnet-for-mysql"
  cidr        = "192.168.1.0/24"
  description = "terraform测试使用"
  dns = [
    "114.114.114.114",
    "8.8.8.8"
  ]
}
 
 
# 创建安全组
resource "ctyun_security_group" "security_group_test" {
  vpc_id      = ctyun_vpc.vpc_test.id
  name        = "security-group-for-mysql"
  description = "terraform测试使用"
}
 
# 查询规格
data "ctyun_ecs_flavors" "ecs_flavor_test" {
  cpu    = 4
  ram    = 8
  arch   = "x86"
  series = "C"
  type   = "CPU_C7"
}
 
# 创建数据库
resource "ctyun_mysql_instance" "mysql_test" {
  vpc_id                = ctyun_vpc.vpc_test.id
  subnet_id             = ctyun_subnet.subnet_test.id
  security_group_id     =ctyun_security_group.security_group_test.id
  name                  = "mysql-test-10"
  storage_type          = "SSD"
  storage_space         = 200
  cycle_type            = "on_demand"
  prod_id               = "Single80"
  flavor_name           = data.ctyun_ecs_flavors.ecs_flavor_test.flavors[0].name
}
