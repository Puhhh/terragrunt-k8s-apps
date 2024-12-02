dependencies {
  paths = ["../prometheus"]
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "kube-system"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "tetragon"
      chart_repo    = "https://helm.cilium.io/"
      chart_version = "1.2.0"
      values_path   = "tetragon.yaml"
    }
  ]
}