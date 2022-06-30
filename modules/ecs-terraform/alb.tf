# alb.tf

resource "aws_alb" "main" {
  name            = "${var.ecs_service_name}-load-balancer"
  internal        = true
//  load_balancer_type = "network"
  subnets         = module.vpc.private_subnets

  enable_deletion_protection = false
//  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "nginx" {
  name        = "${var.ecs_service_name}-target-group"
  port        = var.nginx_port
  protocol    = "HTTP"
//  protocol    = "TCP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
  depends_on = [aws_alb.main]
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.nginx_port
  protocol          = "HTTP"
//  protocol          = "TCP"

  default_action {
    target_group_arn = aws_alb_target_group.nginx.id
    type             = "forward"
  }
}

