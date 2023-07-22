terraform {
  required_providers {
    kind = {
      # https://github.com/tehcyx/terraform-provider-kind/releases

      source  = "tehcyx/kind"
      version = "0.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}
 
