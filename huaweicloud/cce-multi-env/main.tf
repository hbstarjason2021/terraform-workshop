### terraform init
### terraform workspace new dev
### terraform workspace show
### terraform workspace list
### terraform workspace select dev

### terraform plan -var-file=terraform.dev.tfvars
### terraform plan -var-file=terraform.test.tfvars
### terraform plan -var-file=terraform.staging.tfvars
### terraform plan -var-file=terraform.prod.tfvars

### terraform plan -var-file=terraform.dev.tfvars -out tfplan
### terraform apply tfplan

### terraform workspace select dev
### terraform destroy -var-file=terraform.dev.tfvars 
