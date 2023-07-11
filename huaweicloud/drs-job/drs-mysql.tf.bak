
### drs mysql

### https://support.huaweicloud.com/api-drs/drs_03_0104.html

#### https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/drs_job
  

resource "huaweicloud_drs_job" "drs_job" {
  direction = "up"
  engine_type = "mysql"
  name = "drs-test"
  type = "migration"
  # net_type       = "eip"
  # migration_type = "FULL_INCR_TRANS"

  destination_db {
    engine_type = "mysql"
    instance_id = "27d0a136f5e7452b82f11163a32c4a51in01"  ### huaweicloud_rds_instance.mysql.id
    ip = "<ip>"
    password = "<paasword>"
    port = 3306
    subnet_id = "ae4c68a1-98e6-483a-bcf9-9404c55767cb"   ### huaweicloud_rds_instance.mysql.subnet_id
    user = "root"
  }

  source_db {
    engine_type = "mysql"
    ip = "<ip>"
    password = "<paasword>"
    port = 3306
    user = "root"
    # ssl_link    = false
  }

#####

}
