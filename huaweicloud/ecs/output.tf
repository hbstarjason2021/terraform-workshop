
output "slb_eip_address" {
  value = huaweicloud_vpc_eip.myeip.address
}

output "az_name_list" {
 value = data.huaweicloud_availability_zones.myaz.names[*]
}


/*
output "ecs_pass" {
  value = huaweicloud_compute_instance.myinstance.admin_pass
  sensitive = true
}
*/
