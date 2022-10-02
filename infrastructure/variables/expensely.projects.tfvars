region="ap-southeast-2"
terraform_state_bucket_name="expensely-terraform-state"
terraform_state_policy_name="terraform-ap-southeast-2-bucket"
terraform_lock_table_name="expensely-terraform-lock"
terraform_lock_policy_name="terraform-ap-southeast-2-dynamodb"
terraform_key_policy_name="terraform-ap-southeast-2-key"
azure_devops_projects = [
  {
    name = "Shared"
    description = "Shared resources for Expensely"
  },
  {
    name = "Time"
    description = "CICD assets for time domain"
  },
  {
    name = "User"
    description = "CICD assets for security"
  }
]
