### terraform init

### terraform workspace new dev
### terraform workspace new test
### terraform workspace new staging
### terraform workspace new prod

### terraform workspace show
### terraform workspace list

### terraform plan -var-file=terraform.dev.tfvars
### terraform plan -var-file=terraform.test.tfvars
### terraform plan -var-file=terraform.staging.tfvars
### terraform plan -var-file=terraform.prod.tfvars

### terraform workspace select dev
### terraform plan -var-file=terraform.dev.tfvars -out tfplan
### terraform apply tfplan

### terraform apply -var-file=terraform.dev.tfvars
### terraform apply -var-file=terraform.test.tfvars
### terraform apply -var-file=terraform.staging.tfvars
### terraform apply -var-file=terraform.prod.tfvars

### terraform workspace select dev
### terraform destroy -var-file=terraform.dev.tfvars 
