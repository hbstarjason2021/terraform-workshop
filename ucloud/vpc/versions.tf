terraform {
  required_version = ">= 0.12"
}

terraform {
  required_providers {
    ucloud = {
      #source = "ucloud/ucloud"
      source  = "local-registry/ucloud/ucloud"
      version = "~>1.36.0"
    }
  }
}
