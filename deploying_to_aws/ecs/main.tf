provider "aws" {
  region = "eu-west-1" # AWS Region
}

resource "aws_ecs_cluster" "main" {
  name = "mrc-cluster"
}
