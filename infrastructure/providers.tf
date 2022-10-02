provider "aws" {
  region  = var.region
  assume_role {
    role_arn = var.provider_role_arn
  }
  default_tags {
    Application = "Expensely"
    Team = "Platform"
    ManagedBy = "Terraform"
    Environment = "Terraform"
  }
}

variable "azure_devops_org_service_url" {
  type = string
}
variable "azure_devops_personal_access_token" {
  type = string
}
provider "azuredevops" {
  org_service_url = var.azure_devops_org_service_url
  personal_access_token = var.azure_devops_personal_access_token
}
