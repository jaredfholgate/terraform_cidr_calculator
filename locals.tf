locals {
  address_space_split           = split("/", var.address_space)
  address_space_start_ip        = local.address_space_split[0]
  address_space_size            = tonumber(local.address_space_split[1])
  order_by_size                 = { for key, value in var.subnets_and_sizes : "${format("%03s", value)}||${key}" => value }
  virtual_network_address_space = "${local.address_space_start_ip}/${local.address_space_size}"
  subnet_keys                   = keys(local.order_by_size)
  subnet_new_bits               = [for size in values(local.order_by_size) : size - local.address_space_size]
  cidr_subnets                  = cidrsubnets(local.virtual_network_address_space, local.subnet_new_bits...)
  subnets                       = { for key, value in local.order_by_size : split("||", key)[1] => local.cidr_subnets[index(local.subnet_keys, key)] }
}