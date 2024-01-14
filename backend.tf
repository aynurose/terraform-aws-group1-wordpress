terraform {
  backend "s3" {
    bucket = "hellonura"
    key = "wordpress/terraform.tfstate"
    region = "us-east-2"
  }
}