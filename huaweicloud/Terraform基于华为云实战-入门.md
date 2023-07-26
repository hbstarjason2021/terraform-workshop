快速入门：

```bash
### Install Terraform
TF_VERSION=1.4.6
curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
unzip terraform_${TF_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin
terraform version   
terraform -install-autocomplete

```


```bash
### 配置本地provider-huaweicloud
##下载地址：
https://github.com/huaweicloud/terraform-provider-huaweicloud/releases  

## https://support.huaweicloud.com/terraform_faq/index.html

### 以huaweicloud_1.47.1版本为例，本人已搬运回国内网络
curl -LO "https://jihulab.com/hbstarjason/ali-init/-/raw/main/terraform-provider-huaweicloud_1.47.1_linux_amd64.zip"
unzip terraform-provider-huaweicloud_1.47.1_linux_amd64.zip

## 解压缩放入本地目录
mkdir -p ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.47.1/linux_amd64/
cp terraform-provider-huaweicloud_v1.47.1 ~/.terraform.d/plugins/local-registry/huaweicloud/huaweicloud/1.47.1/linux_amd64/

### 验证
terraform version 
Terraform v1.4.6
on linux_amd64
+ provider local-registry/huaweicloud/huaweicloud v1.47.1

```


```bash
### 获取AK/SK信息，下面会使用到
### https://support.huaweicloud.com/usermanual-ca/ca_01_0003.html
cat ~/Downloads/credentials.csv ;echo
User Name,Access Key Id,Secret Access Key
"Sandbox-user",FB2HRVFCE4Q0HFK5KNPX,Z3MhrFF4zLYg7K0cOaUj8gyXHvg8Ct9duCneWyBn

### access_key = XXXXXX
### secret_key = XXXXXXXX
```

任务：

目标：通过Terraform快速创建VPC。

```bash
### 在工作目录下创建“main.tf”文件

### https://support.huaweicloud.com/qs-terraform/index.html



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
  access_key = "my-access-key"   ### 需要替换
  secret_key = "my-secret-key"   ### 需要替换
}

# Create a VPC
resource "huaweicloud_vpc" "vpcdemo" {
  name = "terraform_vpc"
  cidr = "192.168.0.0/16"
}

```


上半部分为HuaweiCloud Provider的配置，包含认证鉴权的内容，请根据[认证与鉴权](https://support.huaweicloud.com/qs-terraform/index.html#index__section10626219155518)配置相关参数；如果使用环境变量方式认证鉴权，可以省略该部分内容。

下半部分描述一个名为vpcdemo的VPC资源，其中VPC名称为terraform_vpc，cidr为192.168.0.0/16。

```bash
### 在工作目录下执行
terraform init

### 验证
terraform validate

### 会显示要创建哪些资源
terraform plan

### 执行应用，根据提示输入“yes”。
## terraform apply -auto-approve
terraform apply

```


至此，在华为云的控制台上可以看到一个名为terraform_vpc的VPC已经创建。

```bash
## 删除资源
terraform destroy

```


