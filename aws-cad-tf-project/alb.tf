resource "aws_lb" "app-alb" {
  name               = "AppLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.PublicALBSG.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet3.id]

  tags = {
    Environment = "AppLoadBalancer"
  }
}

resource "aws_lb_target_group" "app-lb-tg" {
  name     = "AppLBTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.customVPC.id
}

resource "aws_lb_target_group_attachment" "app-lb-tga" {
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.db_server.id
  port             = 80
}
resource "aws_lb_listener" "app-lb-listener" {
  load_balancer_arn = aws_lb.app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}