###### node_pool
### https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/cce_node_pool

resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.mycce.id
  name                     = "myccepool"
  os                       = "EulerOS 2.9"
  initial_node_count       = 2
  flavor_id                = "c7.xlarge.2"
  # availability_zone        = var.availability_zone
  key_pair                 = huaweicloud_compute_keypair.mykeypair.name
  scall_enable             = true
  min_node_count           = 1
  max_node_count           = 10
  scale_down_cooldown_time = 100
  priority                 = 1
  type                     = "vm"

  root_volume {
    size       = 40
    volumetype = "SAS"
  }
  data_volumes {
    size       = 100
    volumetype = "SAS"
  }
}
