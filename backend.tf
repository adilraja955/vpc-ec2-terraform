terraform {
  backend "s3" {
    bucket = "terraformstate32327"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
