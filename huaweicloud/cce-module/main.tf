
module "vpc" {
  source  = "cloud-labs-infra/vpc/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-vpc
  ## source  = "./modules/terraform-huaweicloud-vpc"

  version = "1.2.0"

  name = "dev01"
  region             = "cn-north-4"
  availability_zones = ["cn-north-4a", "cn-north-4c"]
  cidr               = "10.0.240.0/20"
  subnets = {
    public  = ["10.0.240.0/22", "10.0.244.0/22"]
    private = ["10.0.248.0/22", "10.0.252.0/22"]
  }
  private_to_internet = false
  primary_dns         = "100.125.1.250"
  secondary_dns       = "100.125.128.250"

  #nat_snat_floating_ip_ids = [
  #  module.eip.id
  #]

}


module "eip" {
  source  = "cloud-labs-infra/eip/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-eip
  ## source  = "./modules/terraform-huaweicloud-eip"

  version = "1.0.0"

  name         = "dev01"
  name_postfix = "gw-snat"
}


module "keypair" {
  source  = "cloud-labs-infra/keypair/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-keypair
  ## source  = "./modules/terraform-huaweicloud-keypair"

  version = "1.0.0"

  name       = "dev01"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuvqz+PrUSUMk3zLBIJVBkNvpZbULg/T4qJ1TlHMhhobeJk9280U67prXAjgEoF7XVlNjUd/+xzMo23154wmy2obdvj0r091rjKIg2fRzUCjsjaTvb7Myumi7bG9Ktu8l7k9m3jeJJfELIgVFl3N2nUyq5bvd0iy/bVv3oc8SkUBHVARuOloRqXk5ps5as6vHGpB2vYfyhcoAJU0fSdw2GXlFeCMcn/J/sCWq+uLOLs6HYO8CLUtW55k2BMtZ4sOQ/POYmdJc1vTcfAGTRE0glxvd06uiSr36IDTDcYoJuXq5QEU5mpvIyf0vpiOAsHMzFWBz/qFD5oadu38JzEBPqOXjXvJvAiH+YfCj4yY7Luhfzn8yCXlB4+kuTBuySdox3ZXAi1sSwLDz+Ppg4LgMCjNPPwNtUuwCBwp2oIUsMGQeI5NNmpSSKTpvg/y+OlsPcL2PLNywcRBIogvYSR6cxsd7qaO+cD5gE11167am30C9neDdclhiz2qwR3A+V8CU= root@ecs-self"

}


/*

module "ecs" {
  ## source  = "cloud-labs-infra/ecs/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-ecs
  source  = "./modules/terraform-huaweicloud-ecs"

  version = "1.0.0"

  name         = "dev01"
  
}

*/

module "k8s_cluster" {
  source  = "cloud-labs-infra/cce-cluster/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-cce-cluster
  ## source  = "./modules/terraform-huaweicloud-cce-cluster"

  version = "1.0.2"

  name       = "dev01"
  flavor_id  = "cce.s1.small"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.public_subnets_ids[0]
  container_network_type = "overlay_l2"
  ## container_network_type = "eni"
  ## eni_subnet_id = ""
  delete_all = "true"
  cluster_version = "v1.25"
}


module "k8s_node_pool" {
  source  = "cloud-labs-infra/cce-node-pool/huaweicloud"
  ## https://github.com/cloud-labs-infra/terraform-huaweicloud-cce-node-pool
  ## source  = "./modules/terraform-huaweicloud-cce-node-pool"

  version = "1.0.1"

  name         = "dev01"
  name_postfix = "01"

  cluster_id         = module.k8s_cluster.id
  subnet_id          = module.vpc.public_subnets_ids[0]
  key_pair           = module.keypair.name
  flavor_id          = "s6.xlarge.2"
  initial_node_count = 1


  root_volume = {
    volumetype = "SSD"
    size       = 40
  }

  data_volume = {
    volumetype = "SSD"
    size       = 100
  }
}
