
#Call VPC Module First to get the Subnet IDs
 module "terraform-vpc" {
     source      = "../vpc"

   ENVIRONMENT = var.ENVIRONMENT
   AWS_REGION  = var.AWS_REGION
   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
   AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
 }

#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "terraform-rds-subnet-group" {

    name          = "${var.ENVIRONMENT}-terraform-db-snet"
    description   = "Allowed subnets for DB cluster instances"
    subnet_ids    = [
      var.vpc_private_subnet1,
      var.vpc_private_subnet2,
    ]
    tags = {
        Name         = "${var.ENVIRONMENT}_terraform_db_subnet-${timestamp()}"
    }
}


resource "aws_db_instance" "terraform-rds" {
  identifier = "${var.ENVIRONMENT}-terraform-rds"       # Name of DB instance
  allocated_storage = var.TERRAFORM_RDS_ALLOCATED_STORAGE
  storage_type = "gp2"
  engine = var.TERRAFORM_RDS_ENGINE
  engine_version = var.TERRAFORM_RDS_ENGINE_VERSION
  instance_class = var.DB_INSTANCE_CLASS
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  publicly_accessible = var.PUBLICLY_ACCESSIBLE
  username = var.TERRAFORM_RDS_USERNAME
  password = var.TERRAFORM_RDS_PASSWORD
  vpc_security_group_ids = [aws_security_group.terraform-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.terraform-rds-subnet-group.name
  multi_az = "false"
}

output "rds_prod_endpoint" {
  value = aws_db_instance.terraform-rds.endpoint
}