dependencies {
  paths = ["../trust-manager"]
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
      release_name  = "bundle"
      chart_name    = "custom-manifest"
      chart_repo    = "https://puhhh.github.io/helm-repo/"
      chart_version = "0.0.1"
      values_path   = "bundle.yaml"
    }
  ]
  use_helm_custom_values = true
}