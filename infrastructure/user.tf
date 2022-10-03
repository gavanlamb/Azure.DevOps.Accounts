resource "azuredevops_project" "user" {
  name = "User"
  description = "User resources for Expensely"
  visibility = "private"
  version_control = "Git"
  work_item_template = "Scrum"
  features = {
    "boards" = "enabled"
    "repositories" = "disabled"
    "pipelines" = "enabled"
    "testplans" = "enabled"
    "artifacts" = "enabled"
  }
}

resource "azuredevops_variable_group" "user_preview" {
  project_id = azuredevops_project.user.id
  name = "terraform.user.preview"
  description = "Environment variables for Terraform"
  allow_access = true

  variable {
    name = "TF_BACKEND_AWS_KEY_ID"
    secret_value = aws_iam_access_key.user_preview.id
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_SECRET_KEY"
    secret_value = aws_iam_access_key.user_preview.secret
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_REGION"
    value = var.region
  }

  variable {
    name = "TF_ARTIFACT_NAME"
    value = "terraform.user.preview"
  }

  variable {
    name = "TF_CLI_ARGS_INIT"
    value = "-backend-config=\"dynamodb_table=${var.terraform_lock_table_name}\" -backend-config=\"bucket=${var.terraform_state_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"encrypt=true\" -backend-config=\"key=terraform.tfstate\" -backend-config=\"workspace_key_prefix=user\""
  }

  variable {
    name = "INFRACOST_API_KEY"
    secret_value = "ico-mlCr1MM6SRcRiZMObUZOTHucgtH2Lpgt"
    is_secret = true
  }
}
resource "aws_iam_user" "user_preview" {
  name = "terraform.user.preview"
  path = "/cicd/"
  force_destroy = true
}
resource "aws_iam_access_key" "user_preview" {
  user = aws_iam_user.user_preview.name
}
resource "aws_iam_user_policy_attachment" "user_preview_state" {
  user = aws_iam_user.user_preview.name
  policy_arn = data.aws_iam_policy.state.arn
}
resource "aws_iam_user_policy_attachment" "user_preview_lock" {
  user = aws_iam_user.user_preview.name
  policy_arn = data.aws_iam_policy.lock.arn
}
resource "aws_iam_user_policy_attachment" "user_preview_state_key" {
  user = aws_iam_user.user_preview.name
  policy_arn = data.aws_iam_policy.key.arn
}
resource "aws_iam_user_policy_attachment" "user_preview_assume_policy" {
  user = aws_iam_user.user_preview.name
  policy_arn = aws_iam_policy.user_preview_assume_policy.arn
}
resource "aws_iam_policy" "user_preview_assume_policy" {
  name = "terraform.user.preview.assume_role"
  policy = data.aws_iam_policy_document.user_preview_assume_policy.json
}
data "aws_iam_policy_document" "user_preview_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [
      "arn:aws:iam::172837312601:role/terraform.infrastructure",
      "arn:aws:iam::151170476258:role/terraform.infrastructure"
    ]
  }
}

resource "azuredevops_variable_group" "user_production" {
  project_id = azuredevops_project.user.id
  name = "terraform.user.production"
  description = "Environment variables for Terraform"
  allow_access = true

  variable {
    name = "TF_BACKEND_AWS_KEY_ID"
    secret_value = aws_iam_access_key.user_production.id
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_SECRET_KEY"
    secret_value = aws_iam_access_key.user_production.secret
    is_secret = true
  }

  variable {
    name = "TF_BACKEND_AWS_REGION"
    value = var.region
  }

  variable {
    name = "TF_ARTIFACT_NAME"
    value = "terraform.user.production"
  }

  variable {
    name = "TF_CLI_ARGS_INIT"
    value = "-backend-config=\"dynamodb_table=${var.terraform_lock_table_name}\" -backend-config=\"bucket=${var.terraform_state_bucket_name}\" -backend-config=\"region=${var.region}\" -backend-config=\"encrypt=true\" -backend-config=\"key=terraform.tfstate\" -backend-config=\"workspace_key_prefix=user\""
  }

  variable {
    name = "INFRACOST_API_KEY"
    secret_value = "ico-mlCr1MM6SRcRiZMObUZOTHucgtH2Lpgt"
    is_secret = true
  }
}
resource "aws_iam_user" "user_production" {
  name = "terraform.user.production"
  path = "/cicd/"
  force_destroy = true
}
resource "aws_iam_access_key" "user_production" {
  user = aws_iam_user.user_production.name
}
resource "aws_iam_user_policy_attachment" "user_production_state" {
  user = aws_iam_user.user_production.name
  policy_arn = data.aws_iam_policy.state.arn
}
resource "aws_iam_user_policy_attachment" "user_production_lock" {
  user = aws_iam_user.user_production.name
  policy_arn = data.aws_iam_policy.lock.arn
}
resource "aws_iam_user_policy_attachment" "user_production_state_key" {
  user = aws_iam_user.user_production.name
  policy_arn = data.aws_iam_policy.key.arn
}
resource "aws_iam_user_policy_attachment" "user_production_assume_policy" {
  user = aws_iam_user.user_production.name
  policy_arn = aws_iam_policy.user_production_assume_policy.arn
}
resource "aws_iam_policy" "user_production_assume_policy" {
  name = "terraform.user.production.assume_role"
  policy = data.aws_iam_policy_document.user_production_assume_policy.json
}
data "aws_iam_policy_document" "user_production_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [
      "arn:aws:iam::266556396524:role/terraform.infrastructure",
      "arn:aws:iam::556018441473:role/terraform.infrastructure"
    ]
  }
}
