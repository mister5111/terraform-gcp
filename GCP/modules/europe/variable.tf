variable "env" {
  type        = string
}

variable "counts" {
  type        = string
}

variable "internal_cidr" {
  type        = list(string)
}

variable "network_global" {
  type        = string
}

variable "type_machine" {
    type        = string
}
variable "zone_names" {
    type        = list(string)
}

variable "name_and_zone" {
    type        = map(string)
}

variable "s_info" {
    type = tuple([string, string, bool])
}