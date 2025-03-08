# Define the provider
provider "aws" {
  region = "eu-west-1"  # AWS Region
}

# Create an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-terraform-bucket-79224c65-418a-458f-8010-63891ddda928"
  acl    = "private"
}