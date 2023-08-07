
resource "huaweicloud_drs_job" "drs_job" {
  direction = "up"
  engine_type = "mysql"
  name = "drs-test"
  type = "migration"

  # net_type       = "eip"
  net_type       = "vpc"
  migration_type = "FULL_INCR_TRANS"

  destination_db {
    engine_type = "mysql"
    instance_id = data.huaweicloud_rds_instance.myinstance_dest.id
    ip = data.huaweicloud_rds_instance.myinstance_dest.private_ips[0]
    #password = random_password.mypassword.result
    password = var.rds_password
    port = 3306
    subnet_id = data.huaweicloud_vpc_subnet.mysubnet.id
    user = "root"
  }

  source_db {
    engine_type = "mysql"
    instance_id = data.huaweicloud_rds_instance.myinstance.id
    ip = data.huaweicloud_rds_instance.myinstance.private_ips[0]
    #password = random_password.mypassword.result
    password = var.rds_password
    port = 3306
    subnet_id = data.huaweicloud_vpc_subnet.mysubnet.id
    user = "root"
    # ssl_link    = false
  }

}
