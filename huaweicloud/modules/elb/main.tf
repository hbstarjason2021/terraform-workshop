resource "huaweicloud_lb_loadbalancer" "lb" {
  vip_subnet_id = var.subnet_id
}

resource "huaweicloud_lb_listener" "listener" {
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = huaweicloud_lb_loadbalancer.lb.id
}

resource "huaweicloud_lb_pool" "pool" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = huaweicloud_lb_listener.listener.id

  persistence {
    type        = "APP_COOKIE"
    cookie_name = "testCookie"
  }
}

resource "huaweicloud_lb_member" "member" {
  count = length(var.instance_ips)
  address       = var.instance_ips[count.index]
  protocol_port = 80
  pool_id       = huaweicloud_lb_pool.pool.id
  subnet_id     = var.subnet_id
}