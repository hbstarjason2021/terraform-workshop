terraform {
  required_providers {
    ctyun = {
      source  = "ctyun-it/ctyun"
      ### version = "2.1.0"
    }
  }
}

provider "ctyun" {
  az_name = var.az_name
}
