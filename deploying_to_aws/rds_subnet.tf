resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.main_subnet.id] # ✅ Attach our subnet

  tags = {
    Name = "main-db-subnet-group"
  }
}
