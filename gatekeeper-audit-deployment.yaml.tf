resource "kubernetes_manifest" "deployment_gatekeeper_audit" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "control-plane" = "audit-controller"
        "gatekeeper.sh/operation" = "audit"
        "gatekeeper.sh/system" = "yes"
      }
      "name" = "gatekeeper-audit"
      "namespace" = kubernetes_manifest.namespace_gatekeeper_system.object.metadata.name
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "control-plane" = "audit-controller"
          "gatekeeper.sh/operation" = "audit"
          "gatekeeper.sh/system" = "yes"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "container.seccomp.security.alpha.kubernetes.io/manager" = "runtime/default"
          }
          "labels" = {
            "control-plane" = "audit-controller"
            "gatekeeper.sh/operation" = "audit"
            "gatekeeper.sh/system" = "yes"
          }
        }
        "spec" = {
          "automountServiceAccountToken" = true
          "containers" = [
            {
              "args" = [
                "--operation=audit",
                "--operation=status",
                "--logtostderr",
              ]
              "command" = [
                "/manager",
              ]
              "env" = [
                {
                  "name" = "POD_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "apiVersion" = "v1"
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
                {
                  "name" = "POD_NAME"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.name"
                    }
                  }
                },
              ]
              "image" = "openpolicyagent/gatekeeper:v3.4.0-beta.0"
              "imagePullPolicy" = "Always"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 9090
                }
              }
              "name" = "manager"
              "ports" = [
                {
                  "containerPort" = 8888
                  "name" = "metrics"
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 9090
                  "name" = "healthz"
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/readyz"
                  "port" = 9090
                }
              }
              "resources" = {
                "limits" = {
                  "cpu" = "1000m"
                  "memory" = "512Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "256Mi"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "capabilities" = {
                  "drop" = [
                    "all",
                  ]
                }
                "readOnlyRootFilesystem" = true
                "runAsGroup" = 999
                "runAsNonRoot" = true
                "runAsUser" = 1000
              }
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName" = "gatekeeper-admin"
          "terminationGracePeriodSeconds" = 60
        }
      }
    }
  }
}
