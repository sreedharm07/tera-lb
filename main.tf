resource "aws_lb" "alb" {
  name               = local.name
  internal           = var.lb
  load_balancer_type = var.lb-type
  security_groups    = [aws_security_group.sg.id]
  subnets            = var.subnets
  tags = merge(local.tags,{Name= "${var.env}-alb" })
}

resource "aws_lb_listener" "main" {
  count             = var.lb ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn_alb

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ERROR"
      status_code  = "404"
    }
  }
}

resource "aws_security_group" "sg" {
  name        =  "${var.env}-sg"
  description = "${var.env}-sg"
  vpc_id      = var.vpc_id
tags = merge(local.tags,{Name= "${var.env}-sg"})

  ingress {
    description      = "TLS from VPC"
    from_port        = var.sg-port
    to_port          = var.sg-port
    protocol         = "tcp"
    cidr_blocks      = var.cidr-block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

