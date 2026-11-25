variable "cidr" {
  type = list(string)
}

variable "vpc_name_prefix" {
  type = string
}

variable "subnet_name_prefix" {
  type = string
}

variable "sg_rules" {
  type = list(object({
    range        = string # 端口/端口段
    dest_cidr_ip = string # 目标网段
    direction    = string # 出方向还是入方向
    protocol     = string # 协议
  }))
  default = []
}
