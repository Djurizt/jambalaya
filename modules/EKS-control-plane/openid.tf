resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.openid.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-openid", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
    },
  )
}