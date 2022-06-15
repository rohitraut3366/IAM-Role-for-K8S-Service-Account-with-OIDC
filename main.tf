locals {
  oidc_fully_qualified_subjects = format("system:serviceaccount:%s:%s", var.namespace, var.serviceaccount)
}

data "aws_iam_policy_document" "policy" {
  count = length(var.iam_permissions) > 0 ? 1 : 0
  dynamic "statement" {
    for_each = var.iam_permissions
    content {
      actions   = lookup(statement.value, "actions")
      resources = lookup(statement.value, "resources")
    }
  }
}

resource "aws_iam_policy" "policy" {
  count  = length(var.iam_permissions) > 0 ? 1 : 0
  name   = "service-${var.name}"
  policy = data.aws_iam_policy_document.policy[0].json
}

resource "aws_iam_role" "role" {
  name = "eks-${var.name}"
  path = var.role_path

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_arn
      }
      Condition = {
        StringEquals = {
          format("%s:aud", var.oidc_url) = "sts.amazonaws.com",
          format("%s:sub", var.oidc_url) = local.oidc_fully_qualified_subjects
        }
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "policy-attachment" {
  count      = length(var.iam_permissions) > 0 ? 1 : 0
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy[0].arn
}
