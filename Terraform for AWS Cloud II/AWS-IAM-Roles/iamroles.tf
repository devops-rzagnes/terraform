#Roles to access the AWS S3 Bucket
resource "aws_iam_role" "s3-terraform-bucket-role" {
  name               = "s3-terraform-bucket-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

#Policy to attach the S3 Bucket Role
resource "aws_iam_role_policy" "s3-terraform-mybucket-role-policy" {
  name = "s3-terraform-mybucket-role-policy"
  role = aws_iam_role.s3-terraform-bucket-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::terraform-bucket-141",
              "arn:aws:s3:::terraform-bucket-141/*"
            ]
        }
    ]
}
EOF

}

#Instance identifier used to attach the policy to the EC2 instance we create
resource "aws_iam_instance_profile" "s3-terraform-bucket-role-instanceprofile" {
  name = "s3-terraform-bucket-role"
  role = aws_iam_role.s3-terraform-bucket-role.name
}