# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.31"
     }
  }

  // must be existing
  backend "s3" {
    bucket = "flaskapp-tf-state-bucket"
    key = "flask-eks-app/dev/terraform.tfstate"
    region = "ap-southeast-1"
    # dynamodb_table = var.dynamodb_state_table // statelocking
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

// placeholder/null resource required for github workflow
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!-changed"
  }
}


