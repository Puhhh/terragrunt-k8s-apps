dependencies {
  paths = ["../../cilium"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "kyverno"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "kyverno"
      chart_repo    = "https://kyverno.github.io/kyverno/"
      chart_version = "3.3.3"
      values_path   = "kyverno.yaml"
    }
  ]
}