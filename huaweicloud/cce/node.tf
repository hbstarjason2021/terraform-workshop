
resource "huaweicloud_compute_keypair" "mykeypair" {
  name = var.key_pair_name
}


resource "huaweicloud_cce_node" "mynode" {
  cluster_id        = huaweicloud_cce_cluster.mycce.id
  name              = var.node_name
  flavor_id         = var.node_flavor
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  key_pair          = huaweicloud_compute_keypair.mykeypair.name

  root_volume {
    size       = var.root_volume_size
    volumetype = var.root_volume_type
  }
  data_volumes {
    size       = var.data_volume_size
    volumetype = var.data_volume_type
  }
}

data "huaweicloud_images_image" "myimage" {
  name        = var.image_name
  most_recent = true
}


resource "huaweicloud_compute_instance" "myecs" {
  name                        = var.ecs_name
  image_id                    = data.huaweicloud_images_image.myimage.id
  flavor_id                   = var.ecs_flavor
  availability_zone           = data.huaweicloud_availability_zones.myaz.names[0]
  key_pair                    = huaweicloud_compute_keypair.mykeypair.name
  delete_disks_on_termination = true

  system_disk_type = var.root_volume_type
  system_disk_size = var.root_volume_size

  data_disks {
    type = var.data_volume_type
    size = var.data_volume_size
  }

  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }
}

resource "huaweicloud_cce_node_attach" "test" {
  cluster_id = huaweicloud_cce_cluster.mycce.id
  server_id  = huaweicloud_compute_instance.myecs.id
  key_pair   = huaweicloud_compute_keypair.mykeypair.name
  os         = var.os
}
