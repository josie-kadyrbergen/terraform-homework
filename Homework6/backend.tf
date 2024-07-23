terraform {
  backend "s3" {
    bucket = "josie-hw6"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "lock-state"
  }
}