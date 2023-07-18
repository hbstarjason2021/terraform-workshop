# terraform-workshop-AWS   


```bash 
## https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  apt install unzip -y && unzip awscliv2.zip && \
  sudo ./aws/install && \
  aws --version
  
# 创建访问凭据
# 右上角，我的安全凭证-->创建访问秘钥

$ aws configure
AWS Access Key ID [None]: XXXXXX
AWS Secret Access Key [None]: XXXXXX
Default region name [None]: XXXXXX
Default output format [None]:


# https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html#installing-eksctl   
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp    
sudo mv /tmp/eksctl /usr/local/bin    
eksctl version   

```
