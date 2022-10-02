data "aws_iam_policy" "state" {
  name = var.terraform_state_policy_name
}

data "aws_iam_policy" "lock" {
  name = var.terraform_lock_policy_name
}

data "aws_iam_policy" "key" {
  name = var.terraform_key_policy_name
}
