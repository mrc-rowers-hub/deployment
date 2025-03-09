resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = [aws_subnet.main_subnet_a.id, aws_subnet.main_subnet_b.id] # Reference subnets
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}


# Listener Rule for Condition Checker Service
resource "aws_lb_listener_rule" "condition_checker" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1 # Adjusted priority to avoid conflicts

  condition {
    path_pattern {
      values = ["/condition-checker/*"] # Corrected path for this service
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.condition_checker_checker_target_group.arn
  }
}

resource "aws_lb_listener_rule" "members_hub" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 2 # Adjusted priority to avoid conflicts

  condition {
    path_pattern {
      values = ["/condition-checker/*"] # Corrected path for this service
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.members_hub_target_group.arn
  }
}

# Listener Rule for Scheduler Service
resource "aws_lb_listener_rule" "scheduler" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 3

  condition {
    path_pattern {
      values = ["/scheduler/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.scheduler_service_target_group.arn
  }
}

resource "aws_lb_listener_rule" "crm" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 4

  condition {
    path_pattern {
      values = ["/crm/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.crm_target_group.arn
  }
}

resource "aws_lb_listener_rule" "resources" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 5

  condition {
    path_pattern {
      values = ["/crm/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.resources_target_group.arn
  }
}