
resource "huaweicloud_drs_job" "drs_job" {
  for_each       = { for rg in local.rg : rg.name => rg }
  name           = each.value.name_drs
  type           = "migration"
  engine_type    = "mysql"
  direction      = "up"
  #net_type       = "vpc"
  net_type       = "eip"
  migration_type = "FULL_TRANS"
  description    = "multi_self"
  #force_destroy  = "true"

  source_db {
    engine_type = "mysql"
    ip          = each.value.sip

    port        = each.value.sport
    user        = each.value.suser
    password    = each.value.spass
  }

  destination_db {
    #region      = "cn-north-4"
    ip          = huaweicloud_rds_instance.mysql[each.value.name].fixed_ip

    port        = 3306
    engine_type = "mysql"
    user        = "root"
    password    = var.rds_password
    instance_id = huaweicloud_rds_instance.mysql[each.value.name].id
    subnet_id   = huaweicloud_vpc_subnet.mysubnet.id
  }
}

