terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

locals {
  github_oidc_provider_name = "INRA-DEV-GITHUB-OIDC"
  common_tags = {
    Environment = "DEV"
    Owner       = "Devops"
  }
}

# Create Github OIDC Provider
# Only 1 provider is required per account
# This module creates a IAM role for the provider
# Multiple IAM policies can be attached to the provider
module "github_oidc_provider" {
  source = "../modules/github_oidc_provider"
  github_oidc_provider_name = local.github_oidc_provider_name
  tags = local.common_tags
}

# Create an IAM Policy for the Github OIDC Provider
# This policy grants the CI/CD pipeline access to S3 bucket
resource "aws_iam_policy" "github_oidc_provider_s3_policy" {
 name = "${module.github_oidc_provider.github_oidc_provider_name}-POLICY"
 policy = file("${path.root}/files/github_oidc_s3_policy.json")
 tags = merge(local.common_tags,
    {
      Name = "${local.github_oidc_provider_name}-S3-POLICY"
  })
}

# Attach the policy created in previous step
resource "aws_iam_role_policy_attachment" "github_oidc_provider_s3_policy_attachment" {
  role = "${module.github_oidc_provider.github_oidc_role_name}"
  policy_arn = "${aws_iam_policy.github_oidc_provider_s3_policy.arn}"
}

# Output value of the provider role ARN to be used in CI/CD pipeline
output "github_oidc_provider_role_arn" {
  value = module.github_oidc_provider.github_oidc_role_arn
  description = "ARN of the Github OIDC Role"
}