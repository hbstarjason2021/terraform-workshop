### https://registry.terraform.io/providers/hashicorp/helm/latest/docs

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "nginx_demo" {
  name = "nginx-demo"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = "monitoring"
  create_namespace = true
  #namespace  = var.namespace
  #version    = var.kube-version

  # https://github.com/prometheus-community/helm-charts/releases

  version    = "48.6.0"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  set {
    name  = "grafana.service.type"
    value = "NodePort"
  }
}

/*
helm pull  prometheus-community/kube-prometheus-stack
cd kube-prometheus-stack/
sed -i "s#registry.k8s.io#m.daocloud.io/registry.k8s.io#g" charts/kube-state-metrics/values.yaml
sed -i "s#quay.io#m.daocloud.io/quay.io#g" charts/kube-state-metrics/values.yaml

sed -i "s#registry.k8s.io#m.daocloud.io/registry.k8s.io#g" values.yaml
sed -i "s#quay.io#m.daocloud.io/quay.io#g" values.yaml
*/
