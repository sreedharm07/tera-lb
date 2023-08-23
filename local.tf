locals {

  tags = merge(var.tags, { tf-module-name = "lb" }, { env = var.env })
  name = var.lb ? "${var.env}-internal-alb" : "${var.env}-public-alb"

}