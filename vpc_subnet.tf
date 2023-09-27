resource "aws_vpc" "tf_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "terraform_vpc "
  }
}

resource "aws_subnet" "tf_subnet_public" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_subnet_public "
  }
}

resource "aws_internet_gateway" "tf_gateway" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "terraform_gateway"
  }
}

resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_gateway.id
  }
  tags = {
    Name = "terraform_rt"
  }
}

resource "aws_route_table_association" "tf_rt_sb_asso" {
  subnet_id      = aws_subnet.tf_subnet_public.id
  route_table_id = aws_route_table.tf_rt.id
}
