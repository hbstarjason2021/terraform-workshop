
### install terraform 

TF_VERSION="1.5.2"
curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
unzip terraform_${TF_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin
terraform version   
terraform -install-autocomplete

### install kind
### https://github.com/kubernetes-sigs/kind/releases

KIND_VESION="v0.20.0"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/${KIND_VESION}/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
kind version

