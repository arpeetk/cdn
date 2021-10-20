output "github_oidc_provider_name" {
  value = var.github_oidc_provider_name
  description = "Name of Github OIDC Provider"
}

output "github_oidc_role_arn" {
  value = aws_iam_role.github_oidc_role.arn
  description = "ARN of the Github OIDC Role"
}

output "github_oidc_role_name" {
  value = aws_iam_role.github_oidc_role.name
  description = "Name of the Github OIDC Role"
}
