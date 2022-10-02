variable "region" {
  type = string
}

variable "provider_role_arn" {
  type = string
}

variable "terraform_state_bucket_name" {
  type = string
}
variable "terraform_state_policy_name" {
  type = string
}

variable "terraform_lock_table_name" {
  type = string
}
variable "terraform_lock_policy_name" {
  type = string
}

variable "terraform_key_policy_name" {
  type = string
}