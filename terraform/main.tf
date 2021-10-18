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

resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sigstore"]
  thumbprint_list = ["a031c46782e6e6c662c2c87c76da9aa62ccabd8e"]
}

resource "aws_iam_role" "github_oidc_role" {
  name = "IAM-ROLE-GITHUB-OIDC-PROVIDER"
  assume_role_policy = <<POLICY
{ 
      "Version": "2012-10-17",
      "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.github_oidc_provider.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {"token.actions.githubusercontent.com:sub" : "repo:arpeetk/cdn:*" }
            }
        } 
    ]
}
POLICY
}

resource "aws_iam_policy" "github_oidc_s3_access_policy" {
 name = "IAM-ROLE-GITHUB-OIDC-S3-ACCESS-POLICY"

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucketVersions",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::cdn-skiff/*",
                "arn:aws:s3:::cdn-skiff"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "github_oidc_s3_access_policy_attachment" {
  role = "${aws_iam_role.github_oidc_role.name}"
  policy_arn = "${aws_iam_policy.github_oidc_s3_access_policy.arn}"
}