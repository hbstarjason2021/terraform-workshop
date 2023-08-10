
### <drs_job_name>
terraform workspace new  drs-demo  
terraform workspace select drs-demo 

terraform workspace list 

terraform plan -var-file=terraform.drs-demo.tfvars
###  terraform apply -var-file=terraform.drs-demo.tfvars
