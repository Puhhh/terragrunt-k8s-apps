dependencies {
  paths = ["../metallb/metallb"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "nginx"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "ingress-nginx"
      chart_repo    = "https://kubernetes.github.io/ingress-nginx"
      chart_version = "4.12.0-beta.0"
      values_path   = "nginx.yaml"
    }
  ]
}