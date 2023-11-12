#### https://registry.terraform.io/providers/rancher/rke/latest/docs/resources/cluster

terraform {
  required_providers {
    rke = {
      source = "rancher/rke"
      version = ">= 1.4.2"
    }
  }
}

resource rke_cluster "cluster" {
  nodes {
    address = "localhost"
    user    = "root"
    role    = ["controlplane", "worker", "etcd"]
    ssh_key = "${file("~/.ssh/id_rsa")}"
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  sensitive_content  = "${rke_cluster.cluster.kube_config_yaml}"
}
