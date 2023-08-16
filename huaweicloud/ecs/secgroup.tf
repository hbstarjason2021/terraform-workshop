# 创建安全组
resource "huaweicloud_networking_secgroup" "secgroup" {
  # name = "my_secgroup_${local.timestamp}"
  name = var.secgroup_name

}
# 安全组规则-开放80端口
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_80" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
# 安全组规则-开放8081端口，用于websocket通道
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_8081" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 8081
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
# 安全组规则-开放22端口
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_22" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
# 安全组规则-开放443端口
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_443" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
# 安全组规则-开放3306端口
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_3306" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
# 安全组规则-允许ping程序测试弹性云服务器的连通性
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_ping" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
