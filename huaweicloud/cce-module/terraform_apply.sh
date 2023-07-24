
### nohup bash  terraform_apply.sh &

## 在CLI中执行terraform apply前可以使用以下命令开启本地日志跟踪
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log

terraform apply -auto-approve

## terraform destroy -auto-approve
