dependencies {
  paths = ["../metallb/metallb"]
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "ngnix"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "ingress-nginx"
      chart_repo    = "https://kubernetes.github.io/ingress-nginx"
      chart_version = "4.12.0-beta.0"
      values_path   = "ngnix.yaml"
    }
  ]
}