
resource "random_password" "mypassword" {
  length           = 12
  special          = true
  override_special = "!@#%^*-_=+"
}


data "huaweicloud_rds_flavors" "flavor" {
  db_type       = "MySQL"
  db_version    = "5.7"
  #instance_mode = "ha"
}

### source  destination

resource "huaweicloud_rds_instance" "myinstance" {
  name                = "mysql_instance"
  #flavor              = "rds.mysql.n1.large.2.ha"   ### https://support.huaweicloud.com/productdesc-rds/rds_01_0034.html
  flavor              = "rds.mysql.n1.large.2"

  #ha_replication_mode = "async"

  vpc_id              = huaweicloud_vpc.myvpc.id
  subnet_id           = huaweicloud_vpc_subnet.mysubnet.id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [
    data.huaweicloud_availability_zones.myaz.names[0],
    data.huaweicloud_availability_zones.myaz.names[1]
  ]
  db {
    type     = "MySQL"
    version  = "5.7"
    #password = var.rds_password
    password = "Huawei@123"
    #password = random_password.mypassword.result
  }
  volume {
    type = "CLOUDSSD"  ### https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/rds_instance
    size = 40
  }

  #backup_strategy {
  #  start_time = "03:00-04:00"
  #  keep_days  = 7
  #}

}


/*
resource "huaweicloud_rds_read_replica_instance" "myreplica" {
  name                = "myreplica"
  flavor              = "rds.mysql.n1.large.2.rr"
  primary_instance_id = huaweicloud_rds_instance.myinstance.id
  availability_zone   = data.huaweicloud_availability_zones.myaz.names[1]

  volume {
    type = "CLOUDSSD"
  }
  tags = {
    type = "readonly"
  }
}
*/
