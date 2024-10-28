terraform {
  backend "s3" {
    bucket = "my-deploy-app"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}