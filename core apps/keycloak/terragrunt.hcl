dependencies {
  paths = ["../cloudnativepg", "../nginx", "../trust-manager/bundle"]
}

terraform {
  source = "git::https://github.com/Puhhh/terraform-k8s-apps.git?ref=v1.0.0"
}

inputs = {
  namespace_name = "keycloak"
  helm_config = [
    {
      chart_name    = "keycloak"
      chart_repo    = "oci://registry-1.docker.io/bitnamicharts/"
      chart_version = "24.2.2"
      values_path   = "keycloak.yaml"
    },
    {
      release_name  = "database"
      chart_name    = "custom-manifest"
      chart_repo    = "https://puhhh.github.io/helm-repo/"
      chart_version = "0.0.1"
      values_path   = "database.yaml"
    }
  ]
  use_helm_custom_values = true
  helm_custom_values = {
    admin_password     = "${yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.admin_password}"
    pem_crt            = indent(8, yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.tls_crt)
    pem_key            = indent(8, yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.tls_key)
    custom_secret_name = "kubernetes-local"
  }
  create_custom_secrets = true
  custom_secrets = [
    {
      name = "kubernetes-local"
      data = {
        "kubernetes-local.pem" = base64encode(yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).pki_bundle)
      }
      type = "Opaque"
    },
    {
      name = "keycloak-pg-secret"
      data = {
        "db-host"  = base64encode("keycloak-pg-cluster-rw.keycloak.svc.cluster.local")
        "db-port"  = base64encode("5432")
        "db-name"  = base64encode("keycloak")
        "username" = base64encode("keycloak")
        "password" = base64encode(yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.enc.yaml"))).keycloak.cloudnativepg_database_password)
      }
      type = "Opaque"
    }
  ]
}