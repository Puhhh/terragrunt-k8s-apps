include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "helm-dashboard"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "helm-dashboard"
      chart_repo    = "https://helm-charts.komodor.io"
      chart_version = "0.1.10"
      values_path   = "helm-dashboard.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "helm-dashboard-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).helm-dashboard.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).helm-dashboard.tls_key}"
      }
    }
  ]
}