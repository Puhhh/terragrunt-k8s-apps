dependencies {
  paths = ["../cilium"]
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name = "database"
  helm_config = [
    {
      chart_name    = "cloudnative-pg"
      chart_repo    = "https://cloudnative-pg.io/charts/"
      chart_version = "0.22.1"
    }
  ]
}