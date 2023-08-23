locals {

  tags = merge(var.tags, { tf-module-name = "lb" }, { env = var.env })
  name = var.lb ?  "${var.env}-public-alb":"${var.env}-internal-alb"

}