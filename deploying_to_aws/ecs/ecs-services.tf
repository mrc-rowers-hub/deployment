# check all ports align on both

resource "aws_lb_target_group" "condition_checker_checker_target_group" {
  name     = "condition-checker-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/actuator/health" # todo, add this?
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "condition-checker-target-group"
  }
}

resource "aws_ecs_service" "condition_checker" {
  name            = "condition-checker-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.condition-checker.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.condition_checker_checker_target_group.arn
    container_name   = "condition-checker-container" # Corrected container name
    container_port   = 8080                          # Port should match the target group
  }
}

resource "aws_lb_target_group" "resources_target_group" {
  name     = "resources-target-group"
  port     = 8083
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "resources-target-group"
  }
}

resource "aws_ecs_service" "resources" {
  name            = "resources-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.resources.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.resources_target_group.arn
    container_name   = "resources-container"
    container_port   = 8083
  }
}

resource "aws_lb_target_group" "members_hub_target_group" {
  name     = "members-hub-target-group"
  port     = 8082
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "members-hub-target-group"
  }
}

resource "aws_ecs_service" "members-hub" {
  name            = "members-hub-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.members-hub.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.members_hub_target_group.arn
    container_name   = "members-hub-container" # Corrected container name
    container_port   = 8082
  }
}


# CRM - Load Balancer and Target Group
resource "aws_lb_target_group" "crm_target_group" {
  name     = "crm-target-group"
  port     = 8085 # Container port for CRM app
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/health" # Health check URL for CRM
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "crm-target-group"
  }
}

resource "aws_ecs_service" "crm_service" {
  name            = "crm-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.crm.arn
  desired_count   = 1 # Adjust based on the number of tasks you want running
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id] # Reference subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.crm_target_group.arn
    container_name   = "crm-container"
    container_port   = 8085
  }
}

# Scheduler Service - Load Balancer and Target Group
resource "aws_lb_target_group" "scheduler_service_target_group" {
  name     = "scheduler-service-target-group"
  port     = 8081 # Container port for Scheduler service
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type  = "ip"

  health_check {
    path                = "/health" # Health check URL for Scheduler service
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "scheduler-service-target-group"
  }
}


resource "aws_ecs_service" "scheduler_service" {
  name            = "scheduler-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.scheduler-service.arn
  desired_count   = 1 # Adjust based on the number of tasks you want running
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id] # Reference subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.scheduler_service_target_group.arn
    container_name   = "scheduler-service-container"
    container_port   = 8081
  }
}

# Repeat for other apps (members-hub, resources, condition-checker, etc.) by copying the above blocks and changing the app names, ports, etc.
