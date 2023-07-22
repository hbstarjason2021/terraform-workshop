provider "helm" {
  kubernetes {
    host = "${kind_cluster.default.endpoint}"
    cluster_ca_certificate = "${kind_cluster.default.cluster_ca_certificate}"
    client_certificate = "${kind_cluster.default.client_certificate}"
    client_key = "${kind_cluster.default.client_key}"
    ### config_path = "~/.kube/config"
  }
}

resource "helm_release" "argocd" {
  name  = "argocd"

  ### helm repo add argo https://argoproj.github.io/argo-helm
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.41.1"
  create_namespace = true

  #values = [
  #  file("argocd/application.yaml")
  #]
}
