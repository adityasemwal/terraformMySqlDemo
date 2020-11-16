# VPC
resource "aws_vpc" "main"{
  cidr_block = var.CIDR_BLOCK
  instance_tenancy = "default"
  tags = {
    Name = "Terraform"
  }
}

# Subnets
resource "aws_subnet" "test-public"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.SUB_1_CIDR
  map_public_ip_on_launch = "true"
  availability_zone = var.AZ_1
  tags = {
    Name = "Test Public"
  }
}

resource "aws_subnet" "test-private"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.SUB_2_CIDR
  #map_public_ip_on_launch = "true"
  availability_zone = var.AZ_2
  tags = {
    Name = "Test Private"
  }
}

resource "aws_subnet" "test-private2"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.SUB_3_CIDR
  #map_public_ip_on_launch = "true"
  availability_zone = var.AZ_1
  tags = {
    Name = "Test Private2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main-gw"{
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "test_gateway"
  }
}

# Route Table Public
resource "aws_route_table" "main-public"{
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
}

# Route Table Private
resource "aws_route_table" "main-private"{
  vpc_id = aws_vpc.main.id
#  route {
#    cidr_block = var.SUB_2_CIDR
#    #gateway_id = aws_internet_gateway.main-gw.id
#    local_gateway_id = "local"
#  }
}


# route association public
resource "aws_route_table_association" "test-public"{
  subnet_id = aws_subnet.test-public.id
  route_table_id = aws_route_table.main-public.id
}

# route association private
resource "aws_route_table_association" "test-private"{
  subnet_id = aws_subnet.test-private.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "test-private2"{
  subnet_id = aws_subnet.test-private2.id
  route_table_id = aws_route_table.main-private.id
}

output "subnet_public"{
  value = aws_subnet.test-public.id
}

output "subnet_private"{
  value = aws_subnet.test-private.id
}

output "subnet_private2"{
  value = aws_subnet.test-private2.id
}

output "vpc_id"{
  value = aws_vpc.main.id
}
