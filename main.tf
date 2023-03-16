terraform {
  required_version = ">=0.12"
  backend "s3" {
   bucket = "bootcamp30-12-koffi"  
   key = "myapp/state.tfstate"
   region = "us-east-2"
  }
}

provider "aws" {
    region = "us-east-2"
}