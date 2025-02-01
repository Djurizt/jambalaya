
resource "aws_eks_cluster" "eks" {
  name  = format("%s-%s-%s-control-plane", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_version

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    # subnet_ids              = values(var.eks_subnet_ids)
    subnet_ids              = data.aws_subnets.private.ids
  }

  tags = merge(var.common_tags, {
    Name  = format("%s-%s-%s-control-plane", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  })

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller_policy
  ]
}
resource "null_resource" "cluster-auth-apply" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region} --alias ${var.cluster_name}"
  }
depends_on = [ aws_eks_cluster.eks ]
}


