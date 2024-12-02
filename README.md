# Configure Kubernetes Cluster With Terragrunt

## Step 1
```bash
cd core\ apps && terragrunt run-all apply
```

## Step 2
Configure Keycloak [KEYCLOAK.md](https://github.com/Puhhh/Kubernetes/blob/main/KEYCLOAK.md)

## Step 3
```bash
cd additional\ apps && terragrunt run-all apply
```