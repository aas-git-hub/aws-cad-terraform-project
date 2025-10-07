provider "aws" {
  region = var.region

  assume_role {
    role_arn     = "arn:aws:iam::648485682149:role/terraform-execution-role"
    session_name = "terraform"
  }
}