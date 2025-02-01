resource "aws_eks_node_group" "nodes-group" {
  cluster_name    = var.cluster_name
  node_group_name = format("%s-%s-%s-nodegroup", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  node_role_arn   = aws_iam_role.nodes.arn
  version = var.eks_version
  # subnet_ids = values(var.eks_subnets_ids)
  subnet_ids              = data.aws_subnets.private.ids

  capacity_type = var.capacity_type
  ami_type      = var.ami_type
  instance_types = [var.instance_types]
  disk_size      = var.disk_size
  remote_access {
    ec2_ssh_key = var.key_pair
  }

  scaling_config {
    desired_size = var.node_min
    min_size     = var.desired_node
    max_size     = var.node_max
  }

  labels = {
    deployment_nodegroup = var.deployment_nodegroup
  }

  tags = merge(var.common_tags, {
    Name                                            = format("%s-%s-%s-nodegroup", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "${var.shared_owned}"
    "k8s.io/cluster-autoscaler/enabled"             = "${var.enable_cluster_autoscaler}"
    },
  )
}