
locals {
  storageAccountName = "${var.env}${module.randomId.hex}"
  tags = {
    Environment  = var.env
    Createdby    = module.currentInfo.client_id
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}

