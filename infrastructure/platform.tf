resource "aws_iam_user" "platform" {
  name = "terraform.platform"
  path = "/cicd/"
  force_destroy = true
}
resource "aws_iam_access_key" "platform" {
  user = aws_iam_user.platform.name
}
resource "aws_iam_user_policy_attachment" "platform_state" {
  user = aws_iam_user.platform.name
  policy_arn = data.aws_iam_policy.state.arn
}
resource "aws_iam_user_policy_attachment" "platform_lock" {
  user = aws_iam_user.platform.name
  policy_arn = data.aws_iam_policy.lock.arn
}
resource "aws_iam_user_policy_attachment" "platform_state_key" {
  user = aws_iam_user.platform.name
  policy_arn = data.aws_iam_policy.key.arn
}
resource "aws_iam_user_policy_attachment" "platform_assume_policy" {
  user = aws_iam_user.platform.name
  policy_arn = aws_iam_policy.platform_assume_policy.arn
}

resource "aws_iam_policy" "platform_assume_policy" {
  name = "terraform.platform.assume_role"
  policy = data.aws_iam_policy_document.platform_assume_policy.json
}
data "aws_iam_policy_document" "platform_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [
      "arn:aws:iam::829991159560:role/terraform.infrastructure",
      "arn:aws:iam::151170476258:role/terraform.infrastructure",
      "arn:aws:iam::172837312601:role/terraform.infrastructure",
      "arn:aws:iam::556018441473:role/terraform.infrastructure",
      "arn:aws:iam::087484524822:role/terraform.infrastructure",
      "arn:aws:iam::104633789203:role/terraform.infrastructure",
      "arn:aws:iam::266556396524:role/terraform.infrastructure",
      "arn:aws:iam::217292076671:role/terraform.infrastructure",
      "arn:aws:iam::258593516853:role/terraform.infrastructure",
      "arn:aws:iam::931649473445:role/terraform.infrastructure"
    ]
  }
}

data "azuredevops_project" "platform" {
  name = "Platform"
}
resource "azuredevops_variable_group" "platform" {
  project_id = data.azuredevops_project.platform.id
  name = "terraform.platform"
  description = "Environment variables for Terraform"
  allow_access = true

  variable {
    name = "TF_BACKEND_AWS_KEY_ID"
    secret_value = aws_iam_access_key.platform.id
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_SECRET_KEY"
    secret_value = aws_iam_access_key.platform.secret
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_REGION"
    value = var.region
  }

  variable {
    name = "TF_ARTIFACT_NAME"
    value = "terraform.platform"
  }

  variable {
    name = "TF_CLI_ARGS_INIT"
    value = "-backend-config=\"dynamodb_table=${var.terraform_lock_table_name}\" -backend-config=\"bucket=${var.terraform_state_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"encrypt=true\" -backend-config=\"key=terraform.tfstate\" -backend-config=\"workspace_key_prefix=platform\""
  }

  variable {
    name = "INFRACOST_API_KEY"
    secret_value = "ico-mlCr1MM6SRcRiZMObUZOTHucgtH2Lpgt"
    is_secret = true
  }
}
