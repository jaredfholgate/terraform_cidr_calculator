variable "address_space" {
  type        = string
  description = "The address space that is used the virtual network in CIDR notation"
  default     = "10.0.0.0/22"
  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.address_space))
    error_message = "The address space must be in CIDR notation"
  }
}

variable "subnets_and_sizes" {
  type        = map(number)
  description = "The size of the subnets"
  default = {
    "a" = 28
    "b" = 26
    "c" = 26
    "d" = 27
  }
}