resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [
    aws_subnet.main_subnet_a.id, # Subnet in AZ eu-west-1a
    aws_subnet.main_subnet_b.id  # Subnet in AZ eu-west-1b
  ]

  tags = {
    Name = "main-db-subnet-group"
  }
}
