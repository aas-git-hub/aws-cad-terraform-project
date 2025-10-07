variable "region" {
  type        = string
  description = "Enter your AWS Region"
  default     = "ca-central-1"
}

variable "ami" {
  type        = string
  description = "Enter your EC2 Instance Type"
  default     = "ami-00959a3c022b1cc1e"
}

variable "instance_type" {
  type        = string
  description = "Enter your instance_type"
  default     = "t2.micro"
}

variable "vpc_cidr" {
  type        = string
  description = "Enter your VPC CIDR Range"
  default     = "10.40.0.0/16"
}

variable "subnet1_cidr" {
  type        = string
  description = "Enter your Subnet1 CIDR"
  default     = "10.40.1.0/24"
}

variable "subnet2_cidr" {
  type        = string
  description = "Enter your Subnet2 CIDR"
  default     = "10.40.2.0/24"
}

variable "subnet3_cidr" {
  type        = string
  description = "Enter your Subnet3 CIDR"
  default     = "10.40.3.0/24"
}

variable "subnet4_cidr" {
  type        = string
  description = "Enter your Subnet4 CIDR"
  default     = "10.40.4.0/24"
}

variable "AZ1" {
  type        = string
  description = "Enter your AZ1"
  default     = "ca-central-1a"
}

variable "AZ2" {
  type        = string
  description = "Enter your AZ2"
  default     = "ca-central-1a"
}

variable "AZ3" {
  type        = string
  description = "Enter your AZ3"
  default     = "ca-central-1b"
}

variable "AZ4" {
  type        = string
  description = "Enter your AZ4"
  default     = "ca-central-1b"
}

variable "public_subnet_id" {
  description = "Subnet ID to deploy the instance in"
  type        = string
}

variable "public_ec2_sg_id" {
  description = "Security Group ID for the EC2 instance"
  type        = string
}
variable "db_name" {
  description = "DB name"
  type        = string
  default     = "mydb"
}

variable "db_engine" {
  description = "DB Engine"
  type        = string
  default     = "mysql"
}
variable "db_instance_class" {
  description = "RDS Instance Class"
  type        = string
  default     = "db.t3.micro"
}
variable "db_port" {
  description = "DB Port Number"
  type        = number
  default     = 3306
}
variable "db_username" {
  description = "DB username"
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "DB password for RDS Database"
  type        = string
  default     = "root1234"
}