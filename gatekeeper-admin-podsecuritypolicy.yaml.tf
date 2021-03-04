resource "kubernetes_manifest" "podsecuritypolicy_gatekeeper_admin" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "policy/v1beta1"
    "kind" = "PodSecurityPolicy"
    "metadata" = {
      "annotations" = {
        "seccomp.security.alpha.kubernetes.io/allowedProfileNames" = "*"
      }
      "labels" = {
        "gatekeeper.sh/system" = "yes"
      }
      "name" = "gatekeeper-admin"
      "namespace" = "default"
    }
    "spec" = {
      "allowPrivilegeEscalation" = false
      "fsGroup" = {
        "ranges" = [
          {
            "max" = 65535
            "min" = 1
          },
        ]
        "rule" = "MustRunAs"
      }
      "requiredDropCapabilities" = [
        "ALL",
      ]
      "runAsUser" = {
        "rule" = "MustRunAsNonRoot"
      }
      "seLinux" = {
        "rule" = "RunAsAny"
      }
      "supplementalGroups" = {
        "ranges" = [
          {
            "max" = 65535
            "min" = 1
          },
        ]
        "rule" = "MustRunAs"
      }
      "volumes" = [
        "configMap",
        "projected",
        "secret",
        "downwardAPI",
      ]
    }
  }
}