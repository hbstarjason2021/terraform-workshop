
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
  name = "rds_mysql_57_destination"
}

output "myinstance_dest_id" {
  value = data.huaweicloud_rds_instances.myinstance_dest.id
}

data "huaweicloud_rds_instances"  "myinstance"{
  name = "rds_mysql_57"
}

output "myinstance_id" {
  value = data.huaweicloud_rds_instances.myinstance.id
}

output "myinstance_id" {
  value = data.huaweicloud_rds_instances.myinstance.fixed_ip
}
