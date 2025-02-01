
resource "aws_iam_role" "eks_cluster" {
  name               = format("%s-%s-%s-eks-control-plane-role", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-eks-control-plane-role", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = data.aws_iam_policy.amazon_eks_cluster_policy.arn
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_vpc_resource_controller_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = data.aws_iam_policy.eks_vpc_resource_controller.arn
}