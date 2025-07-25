dependencies {
  paths = ["../../cilium"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name         = "metallb-system"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "metallb"
      chart_repo    = "https://metallb.github.io/metallb"
      chart_version = "0.15.2"
      values_path   = "metallb.yaml"
    }
  ]
  use_namespace_labels = true
  namespace_labels = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
}