# Configure Kubernetes Cluster With Terragrunt

## Step 0
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python3 check-for-charts-update.py
```

## Step 1
```bash
cd core\ apps && terragrunt run-all apply
```
```
Group 1
- Module /core apps/cilium

Group 2
- Module /core apps/cert-manager
- Module /core apps/cloudnativepg
- Module /core apps/kyverno/kyverno
- Module /core apps/local-path-provisioner
- Module /core apps/metallb/metallb

Group 3
- Module /core apps/kyverno/policies
- Module /core apps/metallb/ipaddresspool
- Module /core apps/metallb/l2advertisement
- Module /core apps/nginx
- Module /core apps/trust-manager/trust-manager

Group 4
- Module /core apps/trust-manager/bundle

Group 5
- Module /core apps/keycloak
```

## Step 2
Configure Keycloak [KEYCLOAK.md](https://github.com/Puhhh/Kubernetes/blob/main/KEYCLOAK.md)

## Step 3
```bash
cd additional\ apps && terragrunt run-all apply
```
```
Group 1
- Module /additional apps/loki
- Module /additional apps/oauth2-proxy

Group 2
- Module /additional apps/fluent-bit
- Module /additional apps/policy-reporter
- Module /additional apps/prometheus

Group 3
- Module /additional apps/tetragon
```