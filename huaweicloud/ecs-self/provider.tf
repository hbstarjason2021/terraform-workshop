
### https://support.huaweicloud.com/usermanual-terraform/terraform_0001.html

## export HW_ACCESS_KEY="my-access-key"
## export HW_SECRET_KEY="my-secret-key"


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

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = "cn-north-4"
  #access_key = "${var.hw_access_key}"
  #secret_key = "${var.hw_secret_key}"
}


#provider "kubernetes" {
#            config_path    = local_file.kube_config.filename
#            config_context = "external"
#}
