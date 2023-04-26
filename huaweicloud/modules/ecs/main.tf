resource "huaweicloud_compute_instance" "basic" {
  name               = var.instance_name
  image_id           = var.image_id
  flavor_id          = var.flavor_id
  security_group_ids = [var.secgroup_id]
  availability_zone  = var.availability_zone
  user_data          = <<-EOF
                        #!/bin/bash 
                        yum -y install nginx 
                        echo `hostname` >/usr/share/nginx/html/index.html
                        systemctl restart nginx 
                        EOF
  admin_pass        = "devops@123"

  network {
    uuid = var.subnet_id
  }

  lifecycle {
    create_before_destroy = true
  }
}