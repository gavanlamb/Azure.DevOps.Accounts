terraform {
  required_version = ">=1.2.5"
  backend "s3" {
    key = "terraform.tfstate"
    encrypt = true
    workspace_key_prefix = "azure-devops"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}