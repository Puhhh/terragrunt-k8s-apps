dependencies {
  paths = ["../oauth2-proxy"]
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "kyverno"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "policy-reporter"
      chart_repo    = "https://kyverno.github.io/policy-reporter"
      chart_version = "3.0.0-rc.10"
      values_path   = "policy-reporter.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "policy-reporter-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).policy-reporter.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).policy-reporter.tls_key}"
      }
    }
  ]
}