
resource "huaweicloud_rds_instance" "mysql" {
  for_each            = { for rg in local.rg : rg.name => rg }
  name                = each.value.name
  flavor              = each.value.flavor
  #ha_replication_mode = each.value.ha
  vpc_id              = huaweicloud_vpc.myvpc.id
  subnet_id           = huaweicloud_vpc_subnet.mysubnet.id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  #param_group_id      = var.param_group_id
  availability_zone   = [each.value.az]

  db {
    type     = "MySQL"
    version  = "5.7"
    password = var.rds_password
  }

  volume {
    type = "CLOUDSSD"
    size = each.value.size
  }

}
