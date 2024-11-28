include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name         = "agrocd"
  use_helm_custom_values = true
  helm_config = [
    {
      chart_name    = "argo-cd"
      chart_repo    = "https://argoproj.github.io/argo-helm"
      chart_version = "7.7.5"
      values_path   = "argocd.yaml"
    }
  ]
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "argocd-server-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).argocd.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).argocd.tls_key}"
      }
    }
  ]
}