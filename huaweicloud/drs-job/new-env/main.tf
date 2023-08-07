# 定义一些变量，时间戳的作用是避免命名重复。 使用时调用如： ${local.timestamp}
locals {
	timestamp = formatdate("YYYYMMDDhhmmss", timestamp())

 }
