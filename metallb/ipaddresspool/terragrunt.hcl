terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

dependencies {
  paths = ["../"]
}

inputs = {
  namespace_name         = "metallb-system"
  use_helm_custom_values = true
  helm_config = [
    {
      release_name  = "ipaddresspool"
      chart_name    = "custom-manifest"
      chart_repo    = "https://puhhh.github.io/pages-helm-repo/"
      chart_version = "0.0.1"
      values_path   = "ipaddresspool.yaml"
    },
  ]
}