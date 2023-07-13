##### sms task 

resource "huaweicloud_sms_server_template" "sms_server_template" {
  availability_zone = "cn-north-4a"
  name = "ecs-dest"
}

resource "huaweicloud_sms_task" "sms_task" {
  os_type = "LINUX"
  source_server_id = "8878642d-a078-42c8-a871-abb8ae1b6b04"
  type = "MIGRATE_FILE"
  vm_template_id  = huaweicloud_sms_server_template.sms_server_template.id
  action     = "start"
}
