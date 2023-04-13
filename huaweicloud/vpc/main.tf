
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
  access_key = "XXX"
  secret_key = "XXX"
}

# Create a VPC
resource "huaweicloud_vpc" "vpcdemo" {
  name = "terraform_vpc"
  cidr = "192.168.0.0/16"
}
