locals {
	timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
	# ecs 服务器的密码
	# ecspassword="${random_string.password.result}@wm"
	# obs的名称
	obsname = "obs-destination-${local.timestamp}"
  # obs桶策略
  obspolicy = jsonencode({"Statement":[{"Sid": "公共读-${local.obsname}","Effect": "Allow","Principal": {"ID": ["*"]},"Action": ["ListBucket","HeadBucket","GetBucketLocation","ListBucketVersions","GetObject","RestoreObject","GetObjectVersion"],"Resource": ["${local.obsname}","${local.obsname}/*"]}]})
}


## https://support.huaweicloud.com/usermanual-terraform/terraform_0012.html

# 创建obs桶
resource "huaweicloud_obs_bucket" "obs" {
  bucket = local.obsname
  acl    = "public-read"
  tags = {
    type = "bucket"
    env  = "${local.obsname}"
  }
  policy = local.obspolicy
}

#############################

resource "huaweicloud_obs_bucket" "mywebsite" {
  bucket = "mywebsite"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# granting the Read-Only permission to anonymous users
resource "huaweicloud_obs_bucket_policy" "policy" {
  bucket = huaweicloud_obs_bucket.mywebsite.bucket
  policy = <<POLICY
{
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": {"ID": "*"},
      "Action": ["GetObject"],
      "Resource": "mywebsite/*"
    } 
  ]
}
POLICY
}

# put index.html
resource "huaweicloud_obs_bucket_object" "index" {
  bucket = huaweicloud_obs_bucket.mywebsite.bucket
  key    = "index.html"
  source = "index.html"
}

# put error.html
resource "huaweicloud_obs_bucket_object" "error" {
  bucket = huaweicloud_obs_bucket.mywebsite.bucket
  key    = "error.html"
  source = "error.html"
}
