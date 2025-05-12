variable "env" {
  type        = string
}

variable "company" {
  type        = string
}

variable "internal_cidr" {
  type        = list(string)
}

variable "network_global" {
  type        = string
}

variable "zone_names" {
    type        = map(string)
}

variable "type_names" {
    type        = list(string)
}
