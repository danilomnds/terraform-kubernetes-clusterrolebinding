variable "clusterrolebinding" {
  type    = string
  default = null
}

variable "clusterrolename" {
  type    = string
  default = null
}

variable "subjects" {
  type = any
}