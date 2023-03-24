# AWS IAMs Role
resource "aws_iam_role" "iams-ci-global" {
  name               = "iams-ci-global"
  assume_role_policy = data.aws_iam_policy_document.iams_githubci_assume_role_document.json
  max_session_duration = 14400
}

# AWS IAMs Policy Document
data "aws_iam_policy_document" "iams-ci-global_policy" {
  statement {
    sid = "GitHubCIEC2Permissions"
    actions = [
      "ec2:Describe*",
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "account:DisableRegion",
      "account:ListRegions",
      "account:EnableRegion",
      "sts:AssumeRoleWithWebIdentity",
      "iam:ListAttachedUserPolicies",
      "s3:*",
      "dynamodb:*",
      "autoscaling:UpdateAutoScalingGroup"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "GitHubCIIAMSPermissions"
    actions = [
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:CreateInstanceProfile",
      "iam:GetRole",
      "iam:GetInstanceProfile",
      "iam:GetPolicy",
      "iam:DeletePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
      "iam:ListInstanceProfiles",
      "iam:AddRoleToInstanceProfile",
      "iam:CreatePolicy",
      "iam:PassRole",
      "iam:DetachRolePolicy",
      "iam:GetRolePolicy",
      "iam:RemoveRoleFromInstanceProfile"
    ]
    resources = [
      "*"
    ]
  }
}

# AWS IAMs Generate Policy
resource "aws_iam_policy" "iams-ci-global_policy" {
  name   = "iams-ci-global_policy"
  policy = data.aws_iam_policy_document.iams-ci-global_policy.json
}

# AWS IAMs Role Policy Attachment
resource "aws_iam_role_policy_attachment" "iams-ci-global_policy_attachment" {
  role       = aws_iam_role.iams-ci-global.name
  policy_arn = aws_iam_policy.iams-ci-global_policy.arn
}