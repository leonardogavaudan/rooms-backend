# Create an IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.app-name}-ecs-task-execution-role"
  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

# Create an IAM policy for ECS task execution
resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name   = "${var.app-name}-iam-policy-for-ecs-task"
  role   = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}