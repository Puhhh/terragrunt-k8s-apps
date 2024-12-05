include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "kube-system"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "cilium"
      chart_repo    = "https://helm.cilium.io/"
      chart_version = "1.17.0-pre.2"
      values_path   = "cilium.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "hubble-ui-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).hubble-ui.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).hubble-ui.tls_key}"
      }
    }
  ]
}