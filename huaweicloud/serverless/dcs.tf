data "huaweicloud_dcs_flavors" "single_flavors" {
  cache_mode = "single"
  capacity   = 0.125
}
resource "huaweicloud_dcs_instance" "dcs" {
  name               = "dcs-${var.name}"
  engine             = "Redis"
  engine_version     = "4.0"
  capacity           = data.huaweicloud_dcs_flavors.single_flavors.capacity
  flavor             = data.huaweicloud_dcs_flavors.single_flavors.flavors[0].name
  availability_zones = [var.az]
  password           = var.dcs_password
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
}
