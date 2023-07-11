provider "kind" {}

# 定义k8s集群
resource "kind_cluster" "default" {
  name            = "devopscluster"                             # 集群名称
  node_image      = "kindest/node:v1.24.0"                      # kind镜像
  kubeconfig_path = pathexpand(var.kind_cluster_config_path)    # kubeconfig路径
  wait_for_ready  = true  # 等待集群节点ready
  
  # kind配置文件
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    
    # Control节点配置
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        <<-EOT
          kind: InitConfiguration
          imageRepository: registry.aliyuncs.com/google_containers
          networking:
            serviceSubnet: 10.0.0.0/16
            apiServerAddress: "0.0.0.0"
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "ingress-ready=true"
          ---
          kind: KubeletConfiguration
          cgroupDriver: systemd
          cgroupRoot: /kubelet
          failSwapOn: false
        EOT
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
      extra_port_mappings {
        container_port = 6443
        host_port      = 6443
      }
    }

    # worker 节点2
    node {
      role = "worker"
    }

    # worker 节点2
    node {
      role = "worker"
    }
  }
}

# null_resource 用于执行shell命令
# 此步骤用于加载ingress镜像并部署ingress
resource "null_resource" "wait_for_instatll_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      kind load  docker-image k8s.gcr.io/ingress-nginx/controller:v1.2.0 --name devopscluster
      kind load  docker-image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1  --name devopscluster
      kubectl create ns ingress-nginx
      kubectl apply -f ingress.yaml -n ingress-nginx
      printf "\nWaiting for the nginx ingress controller...\n"
      kubectl wait --namespace ingress-nginx \
        --for=condition=ready pod \
	      --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [kind_cluster.default]
}
