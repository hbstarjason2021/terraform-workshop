

```bash

### ucloud
### https://github.com/ucloud/terraform-provider-ucloud


PROVIDER_VERSION="1.36.1"

wget https://jihulab.com/hbstarjason/ali-init/-/raw/main/terraform-provider-ucloud_${PROVIDER_VERSION}_linux_amd64.zip

unzip terraform-provider-ucloud_${PROVIDER_VERSION}_linux_amd64.zip

mkdir -p ~/.terraform.d/plugins/local-registry/ucloud/ucloud/${PROVIDER_VERSION}/linux_amd64/
cp terraform-provider-ucloud_v${PROVIDER_VERSION} ~/.terraform.d/plugins/local-registry/ucloud/ucloud/${PROVIDER_VERSION}/linux_amd64/

```
