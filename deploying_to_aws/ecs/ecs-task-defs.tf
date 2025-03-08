

resource "aws_ecs_task_definition" "crm" {
  family                   = "crm-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "crm-container"
    image     = "043309348262.dkr.ecr.us-east-1.amazonaws.com/crm-repo:latest"
    essential = true
    portMappings = [{
      containerPort = 8085
      hostPort      = 8085
    }]
    environment = [
      {
        name  = "SPRING_DATASOURCE_URL"
        value = "jdbc:mysql://mrc-crm-db.cv4kg2gmi7tb.eu-west-1.rds.amazonaws.com:3306/crm?createDatabaseIfNotExist=true"
      }
    ]
  }])
}

resource "aws_ecs_task_definition" "condition-checker" {
  family                   = "condition-checker-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "condition-checker-container"
    image     = "043309348262.dkr.ecr.eu-west-1.amazonaws.com/condition-checker-repo:latest"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])
}

resource "aws_ecs_task_definition" "members-hub" {
  family                   = "members-hub-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "members-hub-container"
    image     = "043309348262.dkr.ecr.eu-west-1.amazonaws.com/members-hub-repo:latest"
    essential = true
    portMappings = [{
      containerPort = 8082
      hostPort      = 8082
    }]
    environment = [ # update this to have the URLs
      {
        name  = "WEATHER_SERVICE_URL"
        value = "http://condition-checker.<cluster-name>.local:8080/"
      },
      {
        name  = "SCHEDULER_SERVICE_URL"
        value = "http://scheduler-service.<cluster-name>.local:8081/"
      },
      {
        name  = "RESOURCES_SERVICE_URL"
        value = "http://resources.<cluster-name>.local:8083/"
      }
    ]
  }])
}

resource "aws_ecs_task_definition" "resources" {
  family                   = "resources-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "resources-container"
    image     = "043309348262.dkr.ecr.eu-west-1.amazonaws.com/resources-repo:latest"
    essential = true
    portMappings = [{
      containerPort = 8083
      hostPort      = 8083
    }]
    environment = [
      {
        name  = "SPRING_DATASOURCE_URL"
        value = "mrc-resources-db.cv4kg2gmi7tb.eu-west-1.rds.amazonaws.com:3306/crm?createDatabaseIfNotExist=true"
      }
    ]
  }])
}

resource "aws_ecs_task_definition" "scheduler-service" {
  family                   = "scheduler-service-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "members-hub-container"
    image     = "043309348262.dkr.ecr.eu-west-1.amazonaws.com/scheduler-repo:latest"
    essential = true
    portMappings = [{
      containerPort = 8083
      hostPort      = 8083
    }]
    environment = [
      {
        name  = "SPRING_DATASOURCE_URL"
        value = "rowers-hub-db.cv4kg2gmi7tb.eu-west-1.rds.amazonaws.com:3306/crm?createDatabaseIfNotExist=true"
      }
    ]
  }])
}