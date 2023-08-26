data "huaweicloud_obs_buckets" "bucket" {
  bucket = "obs-${var.name}"
}

data "huaweicloud_obs_bucket_object" "pythonsdk" {
  bucket = data.huaweicloud_obs_buckets.bucket
  key    = "var.package_name"
}

data "huaweicloud_obs_bucket_object" "sourcecode" {
  bucket = data.huaweicloud_obs_buckets.bucket
  key    = var.sourcecode_name
}

data "huaweicloud_smn_topics" "topic" {
  name = "smn-${var.name}"
}

resource "huaweicloud_fgs_function" "scale_up" {
  name = var.function_name 
  app = "default"
  memory_size = 128
  runtime = "Python3.6"
  timeout = 3
  handler = "scale.handler"
  code_type = "obs"
  code_url = format("https://%s/%s", data.huaweicloud_obs_bucket.bucket.bucket_domain_name, data.huaweicloud_obs_bucket_object.sourcecode.key)
  #code_url = "https://obs-redis-fq-demo.obs.ap-southeast-3.myhuaweicloud.com/sourcecode.zip"
  depend_list = [huaweicloud_fgs_dependency.huaweicloudsdk.id]
}

resource "huaweicloud_fgs_dependency" "huaweicloudsdk" {
  name    = var.dependency_name
  runtime = "Python3.6"
  link    = format("https://%s/%s", data.huaweicloud_obs_bucket.bucket.bucket_domain_name, data.huaweicloud_obs_bucket_object.pythonsdk.key)
  #link = "https://obs-redis-fq-demo.obs.ap-southeast-3.myhuaweicloud.com/huaweicloudsdk.zip"
}

resource "huaweicloud_fgs_trigger" "smntrigger" {
  function_urn = huaweicloud_fgs_function.scale_up.urn
  type         = "SMN"
  status       = "ACTIVE"

  smn {
    topic_urn = data.huaweicloud_smn_topics.topic.urn
  }
}
