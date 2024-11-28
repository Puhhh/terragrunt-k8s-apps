include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "netfetch"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "netfetch"
      chart_repo    = "https://deggja.github.io/netfetch/"
      chart_version = "0.5.3"
      values_path   = "netfetch.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "netfetch-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).netfetch.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).netfetch.tls_key}"
      }
    }
  ]
}