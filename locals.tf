locals {
  order_by_size = { for key, value in var.subnets_and_sizes : "${format("%03s", value)}||${key}" => value }
  virtual_network_address_space = "${var.address_space_start_ip}/${var.address_space_size}"
  subnet_keys                   = keys(local.order_by_size)
  subnet_new_bits               = [for size in values(local.order_by_size) : size - var.address_space_size]
  cidr_subnets                  = cidrsubnets(local.virtual_network_address_space, local.subnet_new_bits...)
  subnets                       = { for key, value in local.order_by_size : split("||", key)[1] => local.cidr_subnets[index(local.subnet_keys, key)] }
}