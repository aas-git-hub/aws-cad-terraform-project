resource "aws_db_instance" "app-rds" {
  db_name                   = var.db_name
  engine                    = var.db_engine
  engine_version            = "8.0"
  instance_class            = var.db_instance_class
  username                  = var.db_username
  password                  = var.db_password
  port                      = var.db_port
  allocated_storage         = 20
  multi_az                  = true
  skip_final_snapshot       = false
  vpc_security_group_ids    = [aws_security_group.PublicRDSSG.id]
  db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.name
  final_snapshot_identifier = "app-rds-final-snapshot"

  tags = {
    Name = "AppRDS"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet2.id, aws_subnet.subnet4.id]

  tags = {
    Name = "RDSSubnetGroup"
  }
}