variable "drs_job_name" {
  type = string
}


variable "rds_dest" {
  #default = "rds_mysql_57_destination"
  type = string
}

variable "rds_source" {
  #default = "rds_mysql_57"
  type = string
}

variable "rds_password_dest" {
  #default = "Zh9NTF8919w"
  type = string
}

variable "rds_password_source" {
  #default = "Zh9NTF8919w"
  type = string
}

variable "rds_user_dest" {
  #default = "root"
  type = string
}

variable "rds_user_source" {
  #default = "root"
  type = string
}

variable "rds_port_dest" {
  #default = "3306"
  type = string
}

variable "rds_port_source" {
  #default = "3306"
  type = string
}



variable "vpc_name" {
  default = "vpc-source"
  #type = string
}

variable "subnet_name" {
  default = "subnet-source"
  #type = string
}

variable "sg_source" {
  default = "my_secgroup_drs"
  #type = string
}



variable "vpc_name_dest" {
  default = "vpc-dest"
  #type = string
}

variable "subnet_name_dest" {
  default = "subnet-dest"
  #type = string
}

variable "sg_source_dest" {
  default = "rds_secgroup_dest"
  #type = string
}



variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}

