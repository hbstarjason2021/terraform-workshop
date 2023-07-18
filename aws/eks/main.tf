data "aws_availability_zones" "available" {}

locals {
  cluster_name = "utrains-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}
