resource "random_password" "mypassword" {
  length           = 12
  special          = true
  override_special = "!@#%^*-_=+"
}


resource "huaweicloud_rds_instance" "myinstance" {
  name                = "mysql_instance"
  flavor              = "rds.mysql.c2.large.ha"
  ha_replication_mode = "async"
  vpc_id              = huaweicloud_vpc.myvpc.id
  subnet_id           = huaweicloud_vpc_subnet.mysubnet.id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [
    data.huaweicloud_availability_zones.myaz.names[0],
    data.huaweicloud_availability_zones.myaz.names[1]
  ]
  db {
    type     = "MySQL"
    version  = "8.0"
    #password = var.rds_password
    password = "Huawei@123"
    #password = random_password.mypassword.result
  }
  volume {
    type = "ULTRAHIGH"
    size = 40
  }
}


resource "huaweicloud_rds_read_replica_instance" "myreplica" {
  name                = "myreplica"
  flavor              = "rds.mysql.c2.large.rr"
  primary_instance_id = huaweicloud_rds_instance.myinstance.id
  availability_zone   = data.huaweicloud_availability_zones.myaz.names[1]

  volume {
    type = "ULTRAHIGH"
  }
  tags = {
    type = "readonly"
  }
}
