
# terraform-workshop-huaweicloud


```bash
######## wget -qO- https://jihulab.com/hbstarjason/ali-init/-/raw/main/huawei_init.sh| bash

## 配置本地华为云provider
## https://support.huaweicloud.com/terraform_faq/index.html

PROVIDER_VERSION="1.50.0"
wget https://jihulab.com/hbstarjason/ali-init/-/raw/main/terraform-provider-huaweicloud_${PROVIDER_VERSION}_linux_amd64.zip
# curl -LO "https://jihulab.com/hbstarjason/ali-init/-/raw/main/terraform-provider-huaweicloud_1.47.1_linux_amd64.zip"

unzip terraform-provider-huaweicloud_${PROVIDER_VERSION}_linux_amd64.zip

## 解压缩放入本地目录
mkdir -p ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/${PROVIDER_VERSION}/linux_amd64/
cp terraform-provider-huaweicloud_v${PROVIDER_VERSION} ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/${PROVIDER_VERSION}/linux_amd64/



```
