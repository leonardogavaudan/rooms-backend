# Create a ECR repository
resource "aws_ecr_repository" "ecr_repository" {
  name = "${var.app-name}-repository"
}