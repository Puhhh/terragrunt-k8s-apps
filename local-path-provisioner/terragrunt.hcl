include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "local-path-provisioner"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "local-path-provisioner"
      chart_repo    = "https://puhhh.github.io/pages-helm-repo/"
      chart_version = "0.0.30"
      values_path   = "local-path-provisioner.yaml"
    }
  ]
  use_namespace_labels = true
  namespace_labels = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
}