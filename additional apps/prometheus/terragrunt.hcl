dependencies {
  paths = ["../oauth2-proxy"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.1"
}

inputs = {
  namespace_name = "monitoring"
  helm_config = [
    {
      chart_name    = "kube-prometheus-stack"
      chart_repo    = "https://prometheus-community.github.io/helm-charts"
      chart_version = "77.0.1"
      values_path   = "prometheus.yaml"
    }
  ]
  use_helm_custom_values = true
  helm_custom_values = {
    client_secret  = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).grafana.client_secret}"
    admin_password = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).grafana.admin_password}"
  }
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "prometheus-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).prometheus.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).prometheus.tls_key}"
      }
    },
    {
      name = "grafana-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).grafana.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).grafana.tls_key}"
      }
    }
  ]
}