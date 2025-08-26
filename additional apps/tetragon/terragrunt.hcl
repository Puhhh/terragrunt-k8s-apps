dependencies {
  paths = ["../prometheus"]
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
      chart_name    = "tetragon"
      chart_repo    = "https://helm.cilium.io/"
      chart_version = "1.5.0"
      values_path   = "tetragon.yaml"
    }
  ]
}