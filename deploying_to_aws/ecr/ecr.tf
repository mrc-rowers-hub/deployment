resource "aws_ecr_repository" "mrc-crm" {
  name = "crm-repo"
}

resource "aws_ecr_repository" "mrc-resources" {
  name = "resources-repo"
}

resource "aws_ecr_repository" "mrc-scheduler" {
  name = "scheduler-repo"
}

resource "aws_ecr_repository" "mrc-members-hub" {
  name = "members-hub-repo"
}

resource "aws_ecr_repository" "mrc-condition-checker" {
  name = "condition-checker-repo"
}
