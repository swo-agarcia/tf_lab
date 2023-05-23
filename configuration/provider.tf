terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#Backend
  backend "s3" {
    bucket         = "s3-dev-aws-deletme1234-backend"
    key            = "demo-lab-devsecops.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-dev-aws-deletme1234-backend"
    # skip_credentials_validation = true
  }
}

provider "aws" {
  region = var.region
}
