
terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "1.7.1"
    }
  }
}

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
