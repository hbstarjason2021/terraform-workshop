output "instance_id" {
    value = huaweicloud_compute_instance.basic.id
  
}

output "instance_ip" {
    value = huaweicloud_compute_instance.basic.access_ip_v4
}