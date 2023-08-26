
resource "huaweicloud_obs_bucket" "obs_bucket" {
  bucket = "obs-${var.name}"
  acl = "private"
}

resource "huaweicloud_obs_bucket_object" "pythonsdk" {
  bucket = huaweicloud_obs_bucket.obs_bucket.bucket
  key = var.package_name
  source = var.package_location
}

resource "huaweicloud_obs_bucket_object" "sourcecode" {
  bucket = huaweicloud_obs_bucket.obs_bucket.bucket
  key = var.sourcecode_name
  source = var.sourcecode_location
}

