

resource "huaweicloud_oms_migration_task" "oms_migration_task" {
  type = "object"
  destination_object {
    bucket = local.obsname
    region = "cn-north-4"
  }
  source_object {
    access_key = "XXX"
    bucket = "mywebsite"
    object = ["error.html"]
    region = "cn-north-4"
    secret_key = "XXXXXX"
  }
}
