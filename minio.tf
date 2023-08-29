
#### https://github.com/circa10a/terraform-local-minio/

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
    minio = {
      source  = "aminueza/minio"
      version = "~>1.7.1"
    }
  }
}

##################################################################

provider "docker" {
}

resource "docker_network" "network" {
  name = "dev"
}

resource "docker_volume" "minio_volume" {
  name = "minio"
}

resource "docker_image" "minio_image" {
  name = "minio/minio:latest"
  keep_locally = true
}

resource "docker_container" "minio_container" {
  image = docker_image.minio_image.image_id
  name  = "minio"
  hostname = "minio"
  restart = "always"
  networks_advanced {
    name = docker_network.network.name
  }
  ports {
    internal = 9010
    external = 9010
  }
  ports {
    internal = 9011
    external = 9011
  }
  mounts {
    type = "volume"
    target = "/data"
    source = "minio"
  }
  env = [
   "MINIO_ROOT_USER=minioadmin",
   "MINIO_ROOT_PASSWORD=minioadmin"
  ]
  command = ["server", "/data", "--console-address", ":9011", "--address", ":9010"]
  remove_volumes = false
}

##################################################################
/*
export MINIO_ENDPOINT="172.30.1.2:9010"
export MINIO_USER="minioadmin"
export MINIO_PASSWORD="minioadmin"
*/

// @see https://registry.terraform.io/providers/aminueza/minio/latest/docs
provider "minio" {
  minio_server     = "172.30.1.2:9010"
  minio_access_key = "minioadmin"
  minio_secret_key = "minioadmin"
}

resource "minio_s3_bucket" "state_terraform_s3" {
  depends_on = [docker_container.minio_container]
  bucket = "test-bucket-new"
  acl    = "public"
}

resource "minio_s3_object" "txt_file" {
  depends_on = [minio_s3_bucket.state_terraform_s3]
  bucket_name = minio_s3_bucket.state_terraform_s3.bucket
  object_name = "text.txt"
  content = "This is minio_s3_bucket test."
  content_type = "text/plain"
}



output "minio_id" {
  value = "${minio_s3_bucket.state_terraform_s3.id}"
}

output "minio_url" {
  value = "${minio_s3_bucket.state_terraform_s3.bucket_domain_name}"
}

output "minio_object_id" {
  value = "${minio_s3_object.txt_file.id}"
}
