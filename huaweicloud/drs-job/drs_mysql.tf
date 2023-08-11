
###  terraform workspace new  drs-demo  ### <drs_job_name>
###  terraform workspace select drs-demo  
###  terraform plan -var-file=terraform.drs-demo.tfvars
###  terraform apply -var-file=terraform.drs-demo.tfvars

resource "huaweicloud_drs_job" "drs_job" {
  direction = "up"
  engine_type = "mysql"
  name = var.drs_job_name
  type = "migration"
  migrate_definer = false

  # net_type       = "eip"
  net_type       = "vpc"
  #migration_type = "FULL_INCR_TRANS"
  migration_type = "FULL_TRANS"
  # # start_time = "yyyy-MM-dd HH:mm:ss" 

  destination_db {
    engine_type = "mysql"
    instance_id = data.huaweicloud_rds_instances.myinstance_dest.instances[0].id
    #ip = huaweicloud_rds_instances.myinstance_dest.private_ips[0]
    ip = data.huaweicloud_rds_instances.myinstance_dest.instances[0].fixed_ip
    #password = random_password.mypassword.result
    password = var.rds_password_dest
    port = var.rds_port_dest
    subnet_id = data.huaweicloud_vpc_subnet.mysubnet.id
    user = var.rds_user_dest
  }

  source_db {
    engine_type = "mysql"
    instance_id = data.huaweicloud_rds_instances.myinstance.instances[0].id
    #ip = huaweicloud_rds_instances.myinstance.private_ips[0]
    ip = data.huaweicloud_rds_instances.myinstance.instances[0].fixed_ip
    #password = random_password.mypassword.result
    password = var.rds_password_source
    port = var.rds_port_source
    subnet_id = data.huaweicloud_vpc_subnet.mysubnet.id
    user = var.rds_user_source
    # ssl_link    = false
  }

}
