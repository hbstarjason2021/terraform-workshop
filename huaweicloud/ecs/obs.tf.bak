
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
