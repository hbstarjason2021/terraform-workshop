terraform {
  required_providers {
    ctyun = {
      source = "ctyun-it/ctyun"
      ##version = "2.1.1"
    }
  }
}

## export CTYUN_AK=""
## export TYUN_SK=""
## CTYUN_REGION_ID="200000001852"
## CTYUN_AZ_NAME="cn-huabei2-tj1A-public-ctcloud"

### https://registry.terraform.io/providers/ctyun-it/ctyun/latest/docs

provider "ctyun" {
  ## ak        = "ak"
  ## sk        = "sk"
  ## region_id = "200000001852"
  ## az_name   = "cn-huabei2-tj1A-public-ctcloud"
  ### env       = "test"
}
