terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name = "oauth2-proxy"
  helm_config = [
    {
      chart_name    = "oauth2-proxy"
      chart_repo    = "https://oauth2-proxy.github.io/manifests"
      chart_version = "7.8.0"
      values_path   = "oauth2-proxy.yaml"
    }
  ]
  use_helm_custom_values = true
  helm_custom_values = {
    client_secret = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).oauth2-proxy.client_secret}"
    cookie_secret = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).oauth2-proxy.cookie_secret}"
  }
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "oauth2-proxy-tls"
      data = {
        "tls.crt" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).oauth2-proxy.tls_crt}"
        "tls.key" = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).oauth2-proxy.tls_key}"
      }
    }
  ]
}