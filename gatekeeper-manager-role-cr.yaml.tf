resource "kubernetes_manifest" "clusterrole_gatekeeper_manager_role" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "creationTimestamp" = null
      "labels" = {
        "gatekeeper.sh/system" = "yes"
      }
      "name" = "gatekeeper-manager-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "*",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apiextensions.k8s.io",
        ]
        "resources" = [
          "customresourcedefinitions",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "config.gatekeeper.sh",
        ]
        "resources" = [
          "configs",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "config.gatekeeper.sh",
        ]
        "resources" = [
          "configs/status",
        ]
        "verbs" = [
          "get",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "constraints.gatekeeper.sh",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "mutations.gatekeeper.sh",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "policy",
        ]
        "resourceNames" = [
          "gatekeeper-admin",
        ]
        "resources" = [
          "podsecuritypolicies",
        ]
        "verbs" = [
          "use",
        ]
      },
      {
        "apiGroups" = [
          "status.gatekeeper.sh",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "templates.gatekeeper.sh",
        ]
        "resources" = [
          "constrainttemplates",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "templates.gatekeeper.sh",
        ]
        "resources" = [
          "constrainttemplates/finalizers",
        ]
        "verbs" = [
          "delete",
          "get",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "templates.gatekeeper.sh",
        ]
        "resources" = [
          "constrainttemplates/status",
        ]
        "verbs" = [
          "get",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "admissionregistration.k8s.io",
        ]
        "resourceNames" = [
          "gatekeeper-validating-webhook-configuration",
        ]
        "resources" = [
          "validatingwebhookconfigurations",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
    ]
  }
}
