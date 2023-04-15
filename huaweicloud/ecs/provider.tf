
## export hw_region="cn-north-4"
## export hw_access_key="XXX"
## export hw_secret_key="YYY"

terraform {
  required_version = "~> 1.4"

  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      
      ##source  = "local-registry/huaweicloud/huaweicloud"
      
      version = "~>1.47"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = "${var.hw_region}"
  access_key = "${var.hw_access_key}"
  secret_key = "${var.hw_secret_key}"
}


provider "kubernetes" {
            config_path    = local_file.kube_config.filename
            config_context = "external"
}
