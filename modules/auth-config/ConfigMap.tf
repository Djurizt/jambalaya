# # aws-auth ConfigMap to map IAM roles for worker nodes
# resource "kubernetes_config_map" "aws_auth" {
#   metadata {
#     name      = "awsauth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = yamlencode([
#       {
#         rolearn  = var.role_arn
#         username = "system:node:{{EC2PrivateDNSName}}"
#         groups   = ["system:bootstrappers", "system:nodes"]
#       }
#     ])
#   }
# }

# resource "kubernetes_cluster_role" "node_cluster_role" {
#   metadata {
#     name = "node-role"
#   }

#   rule {
#     api_groups = ["", "apps"]
#     resources  = ["pods", "nodes", "services", "endpoints", "persistentvolumeclaims", "replicasets", "statefulsets"]
#     verbs      = ["get", "list", "watch"]
#   }
# }

# resource "kubernetes_cluster_role_binding" "node_cluster_role_binding" {
#   metadata {
#     name = "node-role-binding"
#   }

#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = kubernetes_cluster_role.node_cluster_role.metadata[0].name
#   }

#   subject {
#     kind      = "Group"
#     name      = "system:nodes"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks.endpoint
#   token                  = data.aws_eks_cluster_auth.eks.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
# }
# aws-auth ConfigMap to map IAM role
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "awsauth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = var.role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes", "cluster-admin"]
      }
    ])
  }
}

resource "kubernetes_cluster_role_binding" "admin_role_binding" {
  metadata {
    name = "admin-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin" 
  }

  subject {
    kind      = "Group"
    name      = "system:nodes"
    api_group = "rbac.authorization.k8s.io"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
}
