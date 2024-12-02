remote_state {
  backend = "kubernetes"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    secret_suffix = "${basename(path_relative_to_include())}"
    config_path   = "~/.kube/config"
    namespace     = "terraform-tfstate"
  }
}