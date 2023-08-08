
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
  name = var.sg_source
  #name = "sg-source"
}

output "secgroup_id" {
  value = data.huaweicloud_networking_secgroup.mysecgroup.id
}

#################################

data "huaweicloud_rds_instances"  "myinstance_dest"{
  name = var.rds_dest
}

output "myinstance_dest_id" {
  value = data.huaweicloud_rds_instances.myinstance_dest.id
}

data "huaweicloud_rds_instances"  "myinstance"{
  name = var.rds_source
}

output "myinstance_id" {
  value = data.huaweicloud_rds_instances.myinstance.id
}

output "myinstance_ip" {
  value = data.huaweicloud_rds_instances.myinstance.instances[0].fixed_ip
}

output "myinstance_dest_ip" {
  value = data.huaweicloud_rds_instances.myinstance_dest.instances[0].fixed_ip
}
