#### https://developer.hashicorp.com/terraform/tutorials/docker-get-started/docker-build
#### https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
 # host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "terraform-docker-demo"
  ports {
    internal = 80
    external = 8000
  }
}

### terraform show
### terraform state list
