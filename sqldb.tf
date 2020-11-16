resource "aws_db_subnet_group" "SubnetDB" {
  name       = "main"
  subnet_ids = [aws_subnet.test-private.id,aws_subnet.test-private2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "mysql-instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "dbuser"
  password               = "password"
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.SubnetDB.id
  vpc_security_group_ids = [aws_security_group.allow-connection.id] 
  tags = {
    Name                 = "myTestDB"
    Class                = "Demo"
  }
}
