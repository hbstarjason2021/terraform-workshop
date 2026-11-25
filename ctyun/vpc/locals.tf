### https://www.ctyun.cn/document/11071117/11092506

### ${local.random_string}

locals {

  # 生成当前时间戳的哈希值
  hash = sha256(timestamp())

  # 从哈希结果中截取字符（转为小写并移除特殊字符）
  random_string = substr(
    replace(
      lower(local.hash),
      "/[^a-z0-9]/",
      ""  # 移除所有非字母数字的字符
    ),
    0, 5  # 截取前10个字符
  )
}

