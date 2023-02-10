resource "kubernetes_cluster_role_binding" "clusterrolebinding" {
  metadata {
    name = var.clusterrolebinding == null ? "clusterrolebinding-custom-tim" : var.clusterrolebinding
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.clusterrolename == null ? "clusterrole-custom-tim" : var.clusterrolename
  }
  dynamic "subject" {
    for_each = var.subjects
    content {
      name      = subject.value.name
      namespace = try(subject.value.namespace, null)
      kind      = subject.value.kind
      api_group = try(subject.value.api_group, null)
    }
  }
}