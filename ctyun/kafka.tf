terraform {
  required_providers {
    ctyun = {
      source  = "ctyun-it/ctyun"
      ## version = "2.1.1"
    }
  }
}

provider "ctyun" {

}

variable "kafka_name" {
  type        = string
  description = "kafka实例名称"
  default     = "demo-kafka"
}

variable "kafka_topic_name" {
  type        = string
  description = "topic名称"
  default     = "demo-topic"
}

variable "kafka_consumer_group" {
  type        = string
  description = "消费组名称"
  default     = "demo-consumers"
}

variable "kafka_spec_name" {
  type        = string
  description = "kafka实例的规格类型，可通过https://www.ctyun.cn/document/10029624/10030704或使用ctyun_kafka_specs查看"
  default     = "kafka.2u4g.cluster"
}

variable "kafka_disk_type" {
  type        = string
  description = "磁盘类型，通常支持SAS、SSD、FAST-SSD，规格支持的具体磁盘类型可使用ctyun_kafka_specs查看"
  default     = "SSD"
}

variable "kafka_disk_size" {
  type        = number
  description = "单个节点的磁盘存储空间，单位为GB"
  default     = 100
}

variable "kafka_node_num" {
  type        = number
  description = "节点数，也叫代理个数，单机版为1个，集群版3~50个"
  default     = 3
}

variable "kafka_topic_partition_num" {
  type        = number
  description = "topic的分区数量"
  default     = 1
}

resource "ctyun_vpc" "vpc_test" {
  name = "vpc-for-kafka"
  cidr = "192.168.0.0/16"
}

resource "ctyun_subnet" "subnet_test" {
  vpc_id = ctyun_vpc.vpc_test.id
  name   = "subnet-for-kafka"
  cidr   = "192.168.1.0/24"
  dns = [
    "114.114.114.114",
    "8.8.8.8"
  ]
}

resource "ctyun_security_group" "security_group_test" {
  vpc_id = ctyun_vpc.vpc_test.id
  name   = "sg-for-kafka"
}

data "ctyun_zones" "test" {

}

resource "ctyun_kafka_instance" "test_kafka_instance" {
  instance_name          = var.kafka_name
  engine_version         = "3.6"
  spec_name              = var.kafka_spec_name
  node_num               = var.kafka_node_num
  zone_list              = data.ctyun_zones.test.zones
  disk_type              = var.kafka_disk_type
  disk_size              = var.kafka_disk_size
  vpc_id                 = ctyun_vpc.vpc_test.id
  subnet_id              = ctyun_subnet.subnet_test.id
  security_group_id      = ctyun_security_group.security_group_test.id
  cycle_type             = "month"
  cycle_count            = 3
  auto_renew             = true
  auto_renew_cycle_count = 1
}

resource "ctyun_kafka_topic" "test_kafka_topic" {
  name          = var.kafka_topic_name
  instance_id   = ctyun_kafka_instance.test_kafka_instance.id
  partition_num = var.kafka_topic_partition_num
}

resource "ctyun_kafka_consumer_group" "test_kafka_consumer_group" {
  name        = var.kafka_consumer_group
  instance_id = ctyun_kafka_instance.test_kafka_instance.id
  description = "测试消费组"
}
