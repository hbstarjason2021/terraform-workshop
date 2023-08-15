
/*
resource "random_password" "mypassword" {
  length           = 12
  special          = true
  override_special = "!@#%^*-_=+"
}
*/


data "huaweicloud_rds_flavors" "flavor" {
  db_type       = "MySQL"
  db_version    = "5.7"
  #instance_mode = "ha"
}

################# source  destination

resource "huaweicloud_rds_instance" "myinstance" {
  #name                = "mysql_rds-${count.index}"
  #count               = "2"
  name                = "rds_mysql_57"
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
    password = var.rds_password
    #password = "Zh9NTF8=919w"
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


####################

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "rds-eip"
    size        = 5
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# get the port of rds instance by private_ip
data "huaweicloud_networking_port" "rds_port" {
  network_id = huaweicloud_vpc_subnet.mysubnet.id
  fixed_ip   = huaweicloud_rds_instance.myinstance.private_ips[0]
}

resource "huaweicloud_vpc_eip_associate" "associated" {
  public_ip = huaweicloud_vpc_eip.myeip.address
  port_id   = data.huaweicloud_networking_port.rds_port.id
}


/*
resource "null_resource" "setup_db" {

  provisioner "local-exec" {
    command = <<EOF
        mysql -u root -p Zh9NTF8=919w  -h ${huaweicloud_vpc_eip.myeip.address} < mall.sql
    EOF
  }

  depends_on = [huaweicloud_vpc_eip_associate.associated]
}
*/

##############################

/*
resource "huaweicloud_rds_read_replica_instance" "myreplica" {
  name                = "myreplica"
  flavor              = "rds.mysql.n1.large.2.rr"
  primary_instance_id = huaweicloud_rds_instance.myinstance.id
  availability_zone   = data.huaweicloud_availability_zones.myaz.names[3]

  volume {
    type = "CLOUDSSD"
  }
  tags = {
    type = "readonly"
  }
}
*/
