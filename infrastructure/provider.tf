terraform {

  backend "remote" {
    organization = "Base-Eng-Test"

    workspaces {
      name = "base-eng-test"
    }
  }

  required_version = ">= 1.5.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}


provider "aws" {
  region = var.region
}