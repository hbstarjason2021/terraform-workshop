
data "huaweicloud_vpc" "myvpc" {
   name = var.vpc_name
   #name = "vpc-source"
}

output "vpc_id" {
  value = data.huaweicloud_vpc.myvpc.id
}

data "huaweicloud_vpc_subnet" "mysubnet" {
  name = var.subnet_name
  #name = "subnet-source"
}

output "subne_id" {
  value = data.huaweicloud_vpc_subnet.mysubnet.id
}

data "huaweicloud_networking_secgroup" "mysecgroup" {
  name = var.sg-source
  #name = "sg-source"
}

output "secgroup_id" {
  value = data.huaweicloud_networking_secgroup.mysecgroup.id
}
