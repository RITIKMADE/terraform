resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "private_subnet_a" {
  availability_zone = var.az1
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_a_cidr
    Name = "${var.name}-private-subnet-a"
  }

}


resource "aws_subnet" "private_subnet_b" {
  availability_zone = var.az2
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_b_cidr
  tags = {
    Name = "${var.name}-private-subnet-b"
  }

}


resource "aws_subnet" "public_subnet_a" {
  availability_zone = var.az1
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_a_cidr
  tags = {
    Name = "${var.name}-public-subnet-a"
  }
  map_public_ip_on_launch = true

}


resource "aws_subnet" "public_subnet_b" {
  availability_zone = var.az2
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_b_cidr
  tags = {
    Name = "${var.name}-public-subnet-b"
  }
  map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }

}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {

    cidr_block = join(",", ["10.0.70.0/24", "10.0.122.0/24"])
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_internet_gateway_attachment" "igw" {
  vpc_id              = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}






































