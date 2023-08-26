variable "dcs_password" {}
variable "region" {
  default = "ap-southeast-3"
}
variable "az" {
  default = "ap-southeast-3a"
}
variable "name" {
  default = "redis-fq-demo"
}
variable "package_name" {
  default = "huaweicloudsdk.zip"
}
variable "dependency_name" {
  default = "huaweicloudsdk.zip"
}
variable "package_location" {
  default = "sdk.zip"
}
variable "function_name" {
  default = "redis_fq_scale_up"
}
variable "sourcecode_name" {
  default = "sourcecode.zip"
}
variable "sourcecode_location" {
   default = "./codes/scale.zip"
}
variable "vpc_id" {
  default = "<VPC_ID>"
}
variable "subnet_id" {
  default = "<SUBNET_ID>" 
}
