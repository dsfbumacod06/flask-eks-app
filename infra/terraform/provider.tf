# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.31"
     }
  }

  // s3 for remote state management
  backend "s3" {
    bucket = "flaskapp-tf-state-bucket"
    key = "flask-eks-app/dev/terraform.tfstate"
    region = "ap-southeast-1"
  }

  // dynamodb for state locking
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "Owner": var.owner,
      "Project": var.project
      "Environment": var.environment
    }
  }
}

locals {
  resource_prefix="${var.project}-${var.environment}"  
} 
