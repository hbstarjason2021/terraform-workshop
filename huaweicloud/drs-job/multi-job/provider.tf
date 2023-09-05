
terraform {
  required_version = ">= 1.1"

  required_providers {
    huaweicloud = {
      #source = "huaweicloud/huaweicloud"
      source  = "local-registry/huaweicloud/huaweicloud"
      version = ">= 1.40.0"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = "cn-north-4"
  #access_key = "XXX"
  #secret_key = "XXX"
}

