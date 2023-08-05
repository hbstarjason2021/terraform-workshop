
################# source  destination

resource "huaweicloud_rds_instance" "myinstance" {
  #name                = "mysql_rds-${count.index}"
  #count               = "2"
  name                = "rds_mysql_57_destination"
  #flavor              = "rds.mysql.n1.large.2.ha"   ### https://support.huaweicloud.com/productdesc-rds/rds_01_0034.html
  flavor              = "rds.mysql.n1.large.2"

  #ha_replication_mode = "async"

  vpc_id              = huaweicloud_vpc.myvpc.id
  subnet_id           = huaweicloud_vpc_subnet.mysubnet.id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [
    # data.huaweicloud_availability_zones.myaz.names[0],
    data.huaweicloud_availability_zones.myaz.names[1]
  ]
  db {
    type     = "MySQL"
    version  = "5.7"
    #password = var.rds_password
    password = "Zh9NTF8=919w"
    #password = random_password.mypassword.result
  }
  volume {
    type = "CLOUDSSD"  ### https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/rds_instance
    size = 40
  }

  charging_mode         = "postPaid"
  
  #time_zone = "UTC+08:00"
  #param_group_id  = "3bc1e9cc0d34404b9225ed7a58fb284epr01"
  #enterprise_project_id = “”

  #backup_strategy {
  #  start_time = "03:00-04:00"
  #  keep_days  = 7
  #}

}
