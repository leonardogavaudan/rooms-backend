# Create a Fargate task definition
# Task definition level parameters:
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.app-name}-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "0.25 vCPU"
  memory                   = "0.5 GB"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name         = "${var.app-name}-container"
      image        = "${aws_ecr_repository.ecr_repository.repository_url}:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  ])
}

# Create a Fargate service
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app-name}-service"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 0

  network_configuration {
    subnets = []
  }
}

# Create a Fargate cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app-name}-cluster"
}