provider aws {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "kaizen-josie"
}

resource "aws_s3_bucket" "bucket2" {
  bucket_prefix = "kaizen-"
}

resource "aws_s3_bucket" "imported-bucket1" {
  bucket = "kaizen-aws-bucket1"
}
resource "aws_s3_bucket" "imported-bucket2" {
  bucket = "kaizen-aws-bucket2"
}
# terraform import aws_s3_bucket.imported-bucket1 kaizen-aws-bucket1
# terraform import aws_s3_bucket.imported-bucket2 kaizen-aws-bucket2
