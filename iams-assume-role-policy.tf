# AWS/GitHub Identity Provider Configuration
#https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html
resource "aws_iam_openid_connect_provider" "iams_githubci_identity_provider" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [ "sts.amazonaws.com" ]
  thumbprint_list = [ "6938fd4d98bab03faadb97b34396831e3780aea1" ]
  tags = merge(
    var.GlobalTags,
    {
      Name = "iams_githubci_identity_provider_${var.Env}"
    }
  )
}

# AWS IAMs Role Policy Document
data "aws_iam_policy_document" "iams_githubci_assume_role_document" {
  statement {
    sid     = "GitHubCIAssumeRole"
    effect  = "Allow"
    actions =  [ "sts:AssumeRoleWithWebIdentity" ]
    principals {
      type        = "Federated"
      identifiers = [ aws_iam_openid_connect_provider.iams_githubci_identity_provider.arn ]
    }
    principals {
      type        = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:obrienalaribe/*:*"
      ]
    }
  }
}