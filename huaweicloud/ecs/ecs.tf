
resource "huaweicloud_compute_keypair" "mykeypair" {
  name     = var.keypair_name
  #name      = local.keypair_name
  #name     = "keypair-zhang"
  #key_file = "private_zhang.pem" 
  #key_file = var.private_key_path
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuvqz+PrUSUMk3zLBIJVBkNvpZbULg/T4qJ1TlHMhhobeJk9280U67prXAjgEoF7XVlNjUd/+xzMo23154wmy2obdvj0r091rjKIg2fRzUCjsjaTvb7Myumi7bG9Ktu8l7k9m3jeJJfELIgVFl3N2nUyq5bvd0iy/bVv3oc8SkUBHVARuOloRqXk5ps5as6vHGpB2vYfyhcoAJU0fSdw2GXlFeCMcn/J/sCWq+uLOLs6HYO8CLUtW55k2BMtZ4sOQ/POYmdJc1vTcfAGTRE0glxvd06uiSr36IDTDcYoJuXq5QEU5mpvIyf0vpiOAsHMzFWBz/qFD5oadu38JzEBPqOXjXvJvAiH+YfCj4yY7Luhfzn8yCXlB4+kuTBuySdox3ZXAi1sSwLDz+Ppg4LgMCjNPPwNtUuwCBwp2oIUsMGQeI5NNmpSSKTpvg/y+OlsPcL2PLNywcRBIogvYSR6cxsd7qaO+cD5gE11167am30C9neDdclhiz2qwR3A+V8CU= root@ecs-self"
}


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

resource "time_sleep" "wait_3_minutes" {
  depends_on = [huaweicloud_compute_instance.myinstance]
  create_duration = "180s"
}

# resource "null_resource" "huawei_init" {
#  provisioner "local-exec" {
#    command = "wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash"
#  }
# }
