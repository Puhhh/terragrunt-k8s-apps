dependencies {
  paths = ["../loki"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name         = "kube-system"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "fluent-bit"
      chart_repo    = "https://fluent.github.io/helm-charts"
      chart_version = "0.48.3"
      values_path   = "fluent-bit.yaml"
    }
  ]
  use_namespace_labels = true
  namespace_labels = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
}