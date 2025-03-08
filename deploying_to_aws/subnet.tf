resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main.id # ✅ Uses the VPC we just created
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Change based on your AWS region

  tags = {
    Name = "main-subnet"
  }
}