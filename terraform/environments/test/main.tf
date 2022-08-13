provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "storagefree1231"
    container_name       = "mycontainer"
    key                  = "terraform.tfstate"
    access_key           = "uDJP0VWBn5HOYxBeJrvWJDJDgImlppXtpmxNc7hYGVnr9fxYx7r3TmMJiSZ84DD4LBbhAErTF0K6+AStZcAwlQ=="
  }
}
locals {
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
  tags             = "${local.tags}"
}