#RDS Resources
resource "aws_db_subnet_group" "mariadb-subnets" {
  name        = "mariadb-subnets"
  description = "Amazon RDS subnet group"
  subnet_ids  = [aws_subnet.terraform-vpc-test-private-1.id, aws_subnet.terraform-vpc-test-private-2.id]
}

#RDS Parameters
resource "aws_db_parameter_group" "terraform-mariadb-parameters" {
  name        = "terraform-mariadb-parameters"
  family      = "mariadb10.6"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

#RDS Instance properties
resource "aws_db_instance" "terraform-mariadb" {
  allocated_storage       = 20             # 20 GB of storage
  engine                  = "mariadb"
  engine_version          = "10.6.7"
  instance_class          = "db.t2.micro"  # use micro if you want to use the free tier
  identifier              = "mariadb"
  db_name                    = "mariadb"
  username                = "root"           # username
  password                = "mariadb141"     # password
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnets.name
  parameter_group_name    = aws_db_parameter_group.terraform-mariadb-parameters.name
  multi_az                = "false"            # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 7                                          # how long you’re going to keep your backups
  availability_zone       = aws_subnet.terraform-vpc-test-private-1.availability_zone # prefered AZ
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy
  
  tags = {
    Name = "terraform_mariadb"
  }
}

output "rds" {
  value = aws_db_instance.terraform-mariadb.endpoint
}

