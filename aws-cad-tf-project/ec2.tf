resource "aws_instance" "db_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.PublicALBSG.id]

  associate_public_ip_address = true

  tags = {
    Name = "DatabaseServerInstance"
  }
}
