#Create AWS S3 Bucket

resource "aws_s3_bucket_acl" "terraform-s3bucket" {
  bucket = "terraform-bucket-141"
  acl   = "private"

  tags = {
    Name = "terraform-bucket-141"
  }
}

