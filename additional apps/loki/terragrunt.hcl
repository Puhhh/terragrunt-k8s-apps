include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name         = "loki"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "loki"
      chart_repo    = "https://grafana.github.io/helm-charts"
      chart_version = "6.37.0"
      values_path   = "loki.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "loki-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).loki.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).loki.tls_key}"
      }
    }
  ]
}