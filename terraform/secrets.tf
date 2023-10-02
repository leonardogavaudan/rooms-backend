resource "aws_secretsmanager_secret" "rds_cluster_master_password" {
  name = "${var.rds_cluster_identifier}-master-password"
}

resource "aws_secretsmanager_secret_version" "rds_cluster_master_password" {
  secret_id     = aws_secretsmanager_secret.rds_cluster_master_password.id
  secret_string = var.rds_cluster_master_password
}
