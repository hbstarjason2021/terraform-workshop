# terraform-workshop

```bash
## Install

## https://www.terraform.io/downloads
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

#apt install jq -y
#TF_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)
#echo "TF_VERSION value is : $TF_VERSION"

TF_VERSION="1.5.6"
curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
unzip terraform_${TF_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin
terraform version   
terraform -install-autocomplete


## Use
terraform fmt
terraform validate

terraform init
terraform plan
terraform apply
terraform apply -auto-approve

terraform show
terraform state list
terraform refresh

terraform import

## Graph
apt install graphviz -y
terraform graph | dot -Tpng > graph.png
docker run -d -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx

terraform  plan -destroy 
terraform destroy
```

https://github.com/terraform-group
