
terraform {
  required_version = ">= 0.13"

  required_providers {
    huaweicloud = {
      ### source = "huaweicloud/huaweicloud"
      source  = "local-registry/huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = "cn-north-4"
  #access_key = "XXX"
  #secret_key = "XXX"
}


provider "kubernetes" {
            config_path    = local_file.kube_config.filename
            config_context = "external"
}
