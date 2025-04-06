# Create an IAM role for ECS tasks that allows them to assume the role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# Define a policy to allow ECS tasks to interact with ECR and CloudWatch logs
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "ecs-task-execution-policy"
  description = "Allow ECS tasks to pull images from ECR and write logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",       # Allows ECS to authenticate with ECR
          "ecr:BatchCheckLayerAvailability", # Allows ECS to check the availability of images in ECR
          "ecr:GetDownloadUrlForLayer",      # Allows ECS to download image layers from ECR
          "ecr:BatchGetImage",               # Allows ECS to pull images from ECR
          "logs:CreateLogStream",            # Allows ECS to create a log stream in CloudWatch
          "logs:PutLogEvents"                # Allows ECS to push log events to CloudWatch
        ]
        Effect   = "Allow"
        Resource = "*" # Applies to all resources
      },
    ]
  })
}

# Attach the ECS execution policy to the ECS task execution role
resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
  role       = aws_iam_role.ecs_task_execution_role.name
}
