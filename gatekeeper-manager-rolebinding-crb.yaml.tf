resource "kubernetes_manifest" "clusterrolebinding_gatekeeper_manager_rolebinding" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "gatekeeper.sh/system" = "yes"
      }
      "name" = "gatekeeper-manager-rolebinding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "gatekeeper-manager-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "gatekeeper-admin"
        "namespace" = kubernetes_manifest.namespace_gatekeeper_system.object.metadata.name
      },
    ]
  }
}
