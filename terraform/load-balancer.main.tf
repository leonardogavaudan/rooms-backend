resource "aws_lb" "main" {
  name               = "${var.app-name}-alb"
  # Internal = the ALB is supposed only redirect traffic from inside the VPC
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public.*.id

  # True = Prevents Terraform from deleting the ALB when it is destroyed
  enable_deletion_protection = false
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.main.id
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.main.arn

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.app-name}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}