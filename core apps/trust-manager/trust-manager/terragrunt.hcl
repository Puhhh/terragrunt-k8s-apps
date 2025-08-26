dependencies {
  paths = ["../../cert-manager"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name = "cert-manager"
  helm_config = [
    {
      chart_name    = "trust-manager"
      chart_repo    = "https://charts.jetstack.io/"
      chart_version = "0.19.0"
      values_path   = "trust-manager.yaml"
    },
  ]
  use_helm_custom_values = true
}