variable "address_space_start_ip" {
  type        = string
  description = "The address space that is used the virtual network"
  default     = "10.0.0.0"
}

variable "address_space_size" {
  type        = number
  description = "The address space that is used the virtual network"
  default     = 22
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