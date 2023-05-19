
locals {
  instance_name     = "k8s-node"
  kube_proxy_mode   = "ipvs"
  autoscaler_name = "autoscaler"
  nginx_ingress_name = "nginx-ingress"
  scall_enable = true
}

resource "huaweicloud_cce_addon" "metrics" {
  cluster_id    = huaweicloud_cce_cluster.mycce.id
  template_name = "metrics-server"
  version       = "1.1.4"
}

data "huaweicloud_cce_addon_template" "autoscaler" {
  cluster_id = huaweicloud_cce_cluster.mycce.id
  name       = local.autoscaler_name
  # version    = var.autoscaler_version
  version    = "1.23.17"
}

data "huaweicloud_cce_addon_template" "nginx_ingress" {
  cluster_id = huaweicloud_cce_cluster.mycce.id
  name       = local.nginx_ingress_name
  version    = "2.1.3"
}

