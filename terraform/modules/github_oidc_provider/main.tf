resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
  url = var.github_oidc_provider_url
  client_id_list = var.github_oidc_client_id_list
  thumbprint_list = var.github_oidc_thumbprint_list
  tags = merge(var.tags,
    {
      Name = "${var.github_oidc_provider_name}"
  })
}

resource "aws_iam_role" "github_oidc_role" {
  name = "${var.github_oidc_provider_name}-ROLE"
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
                "StringLike": {"token.actions.githubusercontent.com:sub" : "repo:${var.github_org}/*:*" }
            }
        } 
    ]
}
POLICY
  tags = merge(var.tags,
    {
      Name = "${var.github_oidc_provider_name}-ROLE"
  })
}
