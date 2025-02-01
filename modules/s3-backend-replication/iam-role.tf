resource "aws_iam_role" "replication" {
  provider = aws.source
  name     = format("%s-%s-%s-s3-replication-role", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = { Service = "s3.amazonaws.com" },
        Effect    = "Allow",
        Sid       = ""
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-s3-replication-role", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  })
}

resource "aws_iam_policy" "replication" {
  provider = aws.source
  name     = format("%s-%s-%s-s3-replication-policy", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetReplicationConfiguration", "s3:ListBucket"],
        Effect   = "Allow",
        Resource = [aws_s3_bucket.state.arn]
      },
      {
        Action   = ["s3:GetObjectVersion", "s3:GetObjectVersionAcl"],
        Effect   = "Allow",
        Resource = ["${aws_s3_bucket.state.arn}/*"]
      },
      {
        Action   = ["s3:ReplicateObject"],
        Effect   = "Allow",
        Resource = ["${aws_s3_bucket.backup.arn}/*"]
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-s3-replication-policy", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  })
}

resource "aws_iam_policy_attachment" "replication" {
  provider   = aws.source
  name       = format("%s-%s-%s-s3-replication-policy-attachment", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication.arn
}
