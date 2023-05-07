# Create a Fargate task definition
# Task definition level parameters:
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
resource "aws_ecs_task_definition" "main" {
  family                   = var.task_definition_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "0.25 vCPU"
  memory                   = "0.5 GB"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name         = var.container_name
      image        = "${aws_ecr_repository.main.repository_url}:latest"
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
resource "aws_ecs_service" "main" {
  name            = var.service_name
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 0

  network_configuration {
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  /*
   * Needed to prevent Terraform from trying to update the service
   * - After the service is created, the desired_count is managed by the autoscaling group
   * - After the service is created, the task_definition is managed by Github Actions
   */
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}

# Create a Fargate cluster
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}