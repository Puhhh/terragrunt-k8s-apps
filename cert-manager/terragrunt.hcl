include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "cert-manager"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "cert-manager"
      chart_repo    = "https://charts.jetstack.io/"
      chart_version = "1.16.2"
      values_path   = "cert-manager.yaml"
    }
  ]
}