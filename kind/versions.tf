
##### terraform providers

terraform {
  required_providers {
    kind = {
    
      # https://github.com/tehcyx/terraform-provider-kind/releases
      # .terraform/providers/registry.terraform.io/tehcyx/kind/0.2.0/linux_amd64/terraform-provider-kind

      source  = "tehcyx/kind"
      version = "0.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}
 
