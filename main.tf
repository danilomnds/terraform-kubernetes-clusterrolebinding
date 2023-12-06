resource "kubernetes_cluster_role_binding" "clusterrolebinding" {
  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      annotations   = lookup(metadata.value, "annotations", null)
      generate_name = lookup(metadata.value, "generate_name", null)
      labels        = lookup(metadata.value, "labels", null)
      name          = lookup(metadata.value, "name", null)
    }
  }
  dynamic "role_ref" {
    for_each = var.role_ref != null ? [var.role_ref] : []
    content {
      name      = role_ref.value.name
      kind      = role_ref.value.kind
      api_group = role_ref.value.api_group
    }
  }
  dynamic "subject" {
    for_each = var.subject
    content {
      name      = subject.value.name
      namespace = lookup(subject.value, "namespace", null)
      kind      = subject.value.kind
      api_group = subject.value.kind == "ServiceAccount" ? null : subject.value.api_group 
    }
  }
}