output "vpc_id" {
  value = huaweicloud_vpc.vpc.id
}

output "subnet_id" {
    value = huaweicloud_vpc_subnet.subnet.id
}

output "subnet_subnet_id" {
    value = huaweicloud_vpc_subnet.subnet.subnet_id
}