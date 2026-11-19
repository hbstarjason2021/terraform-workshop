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
## CTYUN_ENV=""

### https://registry.terraform.io/providers/ctyun-it/ctyun/latest/docs

provider "ctyun" {
  ## ak        = "ak"
  ## sk        = "sk"
  ## region_id = "200000001852"  ## 资源池ID 
  ## az_name   = "cn-huabei2-tj1A-public-ctcloud"  ## 资源池的az_name
  ## project_id = ""     ## 企业项目ID，不填则使用用户默认的企业项目
  ### env       = "test"  ## 环境类型env，可选值为：dev：开发环境、test：测试环境、prod：生产环境，默认为生产环境prod
}
