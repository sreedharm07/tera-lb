locals {

  tags = merge(var.tags, { tf-module-name = "lb" }, { env = var.env })

  subnet-ids =


}