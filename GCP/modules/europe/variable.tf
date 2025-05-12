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

variable "type_machine" {
    type        = list(string)
}

variable "zone_names" {
    type        = list(string)
}

variable "zone_and_name" {
    type        = map(string)
}