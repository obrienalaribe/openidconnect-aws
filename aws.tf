# AWS
provider "aws" {
  region  = var.AWSRegion # Region for module to be deployed at
  allowed_account_ids = [ var.AccountID ] # Locking account ID, prevent erroneous deployments
}

# Terragrunt
terraform {
  required_version = "> 1.4.0"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }
  }
}