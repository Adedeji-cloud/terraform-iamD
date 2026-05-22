provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "myDemoBucket2" {
    bucket = "my-demo-buck-008100812"
    acl = "private"
}