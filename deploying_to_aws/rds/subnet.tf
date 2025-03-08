# Subnet in Availability Zone eu-west-1a
resource "aws_subnet" "main_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"  # Subnet in AZ eu-west-1a
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-a"
  }
}

# Subnet in Availability Zone eu-west-1b
resource "aws_subnet" "main_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"  # Subnet in AZ eu-west-1b
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-b"
  }
}
