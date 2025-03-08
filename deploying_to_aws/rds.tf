resource "aws_db_instance" "mrc_crm_db" {
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  identifier             = "mrc-crm-db"
  db_name                = "crm"
  username               = "admin"
  password               = "password123"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  subnet_group_name      = aws_db_subnet_group.main.name
}

resource "aws_db_instance" "mrc_resources_db" {
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  identifier             = "mrc-resources-db"
  db_name                = "mrc_resources"
  username               = "admin"
  password               = "password123"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  subnet_group_name      = aws_db_subnet_group.main.name
}

resource "aws_db_instance" "rowers_hub_db" {
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  identifier             = "rowers-hub-db"
  db_name                = "rowers_hub"
  username               = "admin"
  password               = "password123"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  subnet_group_name      = aws_db_subnet_group.main.name
}
