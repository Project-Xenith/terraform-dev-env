terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:/Users/Sparsh/.aws/credentials" // remember to add drive path as well on windows
  profile                 = "vscode"
}
