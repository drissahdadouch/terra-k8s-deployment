terraform {
  backend "s3" {
    bucket         = "drissahd-file"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-1"  
    encrypt        = true         
    
  }
}
