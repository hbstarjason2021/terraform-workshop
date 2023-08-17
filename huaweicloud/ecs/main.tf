# 定义一些变量，时间戳的作用是避免命名重复。 使用时调用如： ${local.timestamp}
locals {
	timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
	# ecs 服务器的密码
	# ecspassword="${random_string.password.result}@wm"
	# obs的名称
	obsname = "ccebackup-${local.timestamp}"
  # obs桶策略
  obspolicy = jsonencode({"Statement":[{"Sid": "公共读-${local.obsname}","Effect": "Allow","Principal": {"ID": ["*"]},"Action": ["ListBucket","HeadBucket","GetBucketLocation","ListBucketVersions","GetObject","RestoreObject","GetObjectVersion"],"Resource": ["${local.obsname}","${local.obsname}/*"]}]})
}


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!@"
  min_numeric      = 1
  min_lower        = 1
  min_special      = 1
}


