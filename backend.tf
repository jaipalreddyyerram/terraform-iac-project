terraform {
  backend "s3" {
    bucket         = "jaipalreddy-terraform-state-bucket"
    key            = "iac-project/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}