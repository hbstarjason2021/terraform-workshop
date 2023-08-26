
data "huaweicloud_dcs_instances" "dcs_instance" {
  name   = "dcs-redis-fq-demo"
  status = "RUNNING"
}

resource "huaweicloud_ces_alarmrule" "alarm_rule" {
  alarm_name = "alarm-rule-${var.name}"

  metric {
    namespace   = "SYS.DCS"
    metric_name = "used_memory"
    dimensions {
      name  = "dcs_instance_id"
      value = data.huaweicloud_dcs_instances.dcs_instance.instances[0].id
    }
  }
  condition {
    period              = 300
    filter              = "average"
    comparison_operator = ">"
    value               = 8000000
    unit                = "byte"
    count               = 1
  }
}
