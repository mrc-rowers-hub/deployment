resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow database access"
  vpc_id      = aws_vpc.main.id # ✅ This now exists!

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 🔴 WARNING: Open to all! Restrict for security.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}
