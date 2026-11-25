variable "ecs_count" {
  type = number
}

variable "instance_name_prefix" {
  type = string
}

variable "display_name_prefix" {
  type = string
}

variable "flavor_name" {
  type = string
}

variable "image_id" {
  type = string
}

variable "system_disk_type" {
  type = string
}

variable "system_disk_size" {
  type = number
}

variable "vpc_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "status" {
  type    = string
  default = "running"
}

variable "passwords" {
  type = list(string)
}

variable "bandwidth" {
  type    = number
}
