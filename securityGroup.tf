resource "aws_security_group" "allow-connection"{
  vpc_id = aws_vpc.main.id
  name = "allow-connection"
  description = "security group that allow traffic on port 3306"
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  dynamic "ingress"{
    for_each = var.ports
    content{
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = ingress.value
    }
  }
  tags = {
    Name = "allow-connection"
  }
}
