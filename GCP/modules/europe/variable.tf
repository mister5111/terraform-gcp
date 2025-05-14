variable "env" {
  type        = string
}

variable "internal_cidr" {
  type        = list(string)
}

variable "network_global" {
  type        = string
}

variable "type_machine" {
    type        = list(string)
}

variable "zone_names" {
    type        = list(string)
}

variable "name_and_zone" {
    type        = map(string)
}