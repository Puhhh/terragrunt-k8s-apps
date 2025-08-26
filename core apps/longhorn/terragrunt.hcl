dependencies {
  paths = ["../cilium"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name         = "longhorn"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "longhorn"
      chart_repo    = "https://charts.longhorn.io"
      chart_version = "1.9.1"
      values_path   = "longhorn.yaml"
    }
  ]
  use_namespace_labels = true
  namespace_labels = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
  use_helm_custom_values = true
  helm_custom_values = {
    pem_crt = indent(8, yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).longhorn.tls_crt)
    pem_key = indent(8, yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).longhorn.tls_key)
  }
}