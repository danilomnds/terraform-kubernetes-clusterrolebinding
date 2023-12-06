variable "metadata" {
  type = object({
    annotations   = optional(map(string))
    generate_name = optional(string)
    labels        = optional(map(string))
    name          = string
  })
  default = {
    name = "readerclusterrolebinding"
  }
}

variable "role_ref" {
  type = object({
    name      = string
    kind      = string
    api_group = string
  })
  default = {
    name      = "readerclusterrole"
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
  }
}

variable "subject" {
  type = list(object({
    name      = string
    namespace = optional(string)
    kind      = string
    api_group = string
  }))
  default = []
}