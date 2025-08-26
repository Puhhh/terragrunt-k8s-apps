import requests
import hcl2
from pathlib import Path

base_url = "https://artifacthub.io/api/v1/packages/helm"
folders = [Path('additional apps'), Path('core apps')]
packages = [
    'bitnami/keycloak',
    'cert-manager/cert-manager',
    'cert-manager/trust-manager',
    'cilium/cilium',
    'cilium/tetragon',
    'cloudnative-pg/cloudnative-pg',
    'fluent/fluent-bit',
    'grafana/loki',
    'ingress-nginx/ingress-nginx',
    'kyverno/kyverno',
    'kyverno/kyverno-policies',
    'longhorn/longhorn',
    'metallb/metallb',
    'oauth2-proxy/oauth2-proxy',
    'policy-reporter/policy-reporter',
    'prometheus-community/kube-prometheus-stack'
    ]

registry_versions = {}

for line in packages:
    endpoints = line.strip()
    url = f"{base_url}/{endpoints}"
    response = requests.get(url)
    data = response.json()
    chart_name = endpoints.split('/')[-1]
    registry_versions[chart_name] = data['version']

for base_folder in folders:
    for tg_file in base_folder.rglob('terragrunt.hcl'):
        if tg_file.parent == base_folder:
            continue
        with open(tg_file) as file:
            data = hcl2.load(file)
            inputs = data.get('inputs')
            helm_configs = inputs.get('helm_config', [])
            for helm in helm_configs:
                current_version = helm.get('chart_version')
                chart_name = helm.get('chart_name')
                if chart_name in registry_versions:
                    registry_version = registry_versions[chart_name]
                    if current_version != registry_version:
                        print(
                            f"Файл: {tg_file}\n"
                            f"В terragrunt.hcl: {current_version}\n"
                            f"В ArtifactHub:   {registry_version}\n"
                        )