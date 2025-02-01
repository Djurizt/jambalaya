data "aws_eks_cluster_auth" "eks" {
  name = "dev-jurist-blueops-control-plane"
}

data "aws_eks_cluster" "eks" {
  name = "dev-jurist-blueops-control-plane"
}
data "tls_certificate" "openid" {
  url = data.aws_eks_cluster.eks.identity.0.oidc.0.issuer
}