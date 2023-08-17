

resource "huaweicloud_compute_instance" "myinstance" {
  name               = "ecs-basic"
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  security_groups   = [var.secgroup_name]
  #security_group_ids = [huaweicloud_networking_secgroup.default.id]
  
  availability_zone  = data.huaweicloud_availability_zones.myaz.names[0]
  system_disk_type   = "SSD"
  admin_pass        = "Huawei123" 
  #admin_pass        = random_password.password.result
  
  # charging_mode = "prePaid"
  # period_unit   = "month"
  # period        = 1
  
  ## wget http://mirrors.myhuaweicloud.com/repo/mirrors_source.sh && sh mirrors_source.sh
  ## user_data = "#!/bin/bash\napt-get update -y && wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash"
  user_data         = <<-EOF
#!/bin/bash
echo 'root:Huawei@123' | passwd root --stdin > /dev/null 2>&1
apt-get update -y
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/ali.sh | bash
sleep 15
wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash
sleep 5
EOF

# 注意有坑：设置了user_data字段后，admin_pass字段将无效
# https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/examples/ecs/userdata/main.tf
  
  network {
    uuid = huaweicloud_vpc_subnet.mysubnet.id
  }
}

