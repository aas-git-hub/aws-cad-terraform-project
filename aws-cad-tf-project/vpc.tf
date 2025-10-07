# Project Requirement:
# 1. It will be 2 Tier Application with Web and Database
# 2. Deployment of a CustomVPC [vpc.tf]
#Create a VPC in ca-central-1 region with CIDR 10.40.0.0/16
#Create an IGW and attach the IGW to VPC
#Create a Route Table in the VPC
#Create a Route of 0.0.0.0/0 where GW will be IGW
#Create Subnet-1 in ca-central-1a, CIDR: 10.40.1.0/24
#Create Subnet-2 in ca-central-1a, CIDR: 10.40.2.0/24
#Create Subnet-3 in ca-central-1b, CIDR: 10.40.3.0/24
#Create Subnet-4 in ca-central-1b, CIDR: 10.40.4.0/24
#Modify Subnet-1 and Subnet-3 to Auto-Assign Public IP
#Add Subnet-1 and Subnet-3 to Public Route Table
#Create a Securitygroup: PublicEC2SG, Ports: 22, 80, CIDR: 0.0.0.0/0 - Done
#Create a Securitygroup: PublicALBSG, Ports: 80, 443 CIDR: 0.0.0.0/0
#Create a Securitygroup: RDSSG, Ports: 3306 CIDR: 0.0.0.0/0
# 3. Deployment of an EC2 Instance [aws_instance]
# AMI-ID var
# instance-type var
# public_subnet
# PublicEC2SG
# 4. Deployment of a Application Load Balancer [alb.tf]
# aws_lb
# aws_lb_target_group
# aws_lb_target_group_attachment where EC2-Instance-ID will be target
# aws_lb_listener
# 5. Deployment of an RDS Instance [aws_db_instance] [rds.tf]
# DBInstanceID
# DBName
# DBEngine
# UserName
# Password
# DBPort
# Multi-AZ
# Use RDS-SG 
# Use RDS-DB-SubnetGroup [deploy resource aws_db_subnet_group]


resource "aws_vpc" "customVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "CustomVPC"
  }
}

resource "aws_internet_gateway" "customIGW" {
  vpc_id = aws_vpc.customVPC.id

  tags = {
    Name = "CustomIGW"
  }
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.customVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.customIGW.id
  }

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.customVPC.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.AZ1
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.customVPC.id
  cidr_block        = var.subnet2_cidr
  availability_zone = var.AZ1

  tags = {
    Name = "Subnet2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.customVPC.id
  cidr_block              = var.subnet3_cidr
  availability_zone       = var.AZ2
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet3"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.customVPC.id
  cidr_block        = var.subnet4_cidr
  availability_zone = var.AZ2

  tags = {
    Name = "Subnet4"
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.publicRT.id
}

resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.publicRT.id
}

resource "aws_security_group" "PublicEC2SG" {
  name        = "CustomPublicEC2SGTerraform"
  description = "Allow inbound traffic on 22, 80 and all outbound traffic"
  vpc_id      = aws_vpc.customVPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "PublicALBSG" {
  name        = "CustomPublicALBSGTerraform"
  description = "Allow inbound traffic on 80, 443 and all outbound traffic"
  vpc_id      = aws_vpc.customVPC.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "PublicRDSSG" {
  name        = "CustomPublicALBSGTerraform"
  description = "Allow inbound traffic on 3306 and all outbound traffic"
  vpc_id      = aws_vpc.customVPC.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


