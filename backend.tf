terraform {
  backend "s3" {
    
    bucket     = "practise-terraform"
    key        = "stage01/terraform.tfstate"
    region     = "ap-south-1"
  }
}