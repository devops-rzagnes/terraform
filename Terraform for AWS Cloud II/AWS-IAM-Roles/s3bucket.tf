#Create AWS S3 Bucket

resource "aws_s3_bucket" "terraform-s3bucket" {
  bucket = "terraform-bucket-141"
  acl   = "private"
  force_destroy = true

  tags = {
    Name = "terraform-bucket-141"
    Environment = "Development"
  }
}
