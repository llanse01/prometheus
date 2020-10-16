# Usage
<!--- BEGIN_TF_DOCS --->
## Providers

| Name | Version |
|------|---------|
| helm | >= 1.2.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| alertmanager\_cert | Name of Alertmanager certificate | `string` | n/a | yes |
| alertmanager\_from | From Address for alermanager | `string` | n/a | yes |
| alertmanager\_host | Alertmanager Host | `string` | n/a | yes |
| alertmanager\_receiver\_name | List of name for Alertmanager receiver | `string` | n/a | yes |
| alertmanager\_smtp\_smarthost | Alertmanager SMTP Smarthost | `string` | n/a | yes |
| alertmanager\_to\_email | List of Adresses to sed alerts to | `string` | n/a | yes |
| chart\_version | Version on Chart | `string` | `"9.4.8"` | no |
| domain | Domain used | `string` | n/a | yes |
| grafana | Add grafana plugin | `bool` | `"true"` | no |
| grafana\_cert | grafana cert | `string` | n/a | yes |
| grafana\_host | grafana host | `string` | n/a | yes |
| prometheus\_cert | Certifcate name (secret) | `string` | n/a | yes |
| prometheus\_chart | Name of Prometheus chart | `string` | `"kube-prometheus-stack"` | no |
| prometheus\_host | Prometheus host | `string` | n/a | yes |
| prometheus\_issuer | Issure to use for Prometheus | `string` | n/a | yes |
| repo | Prometheus Operator Repository | `string` | `"https://prometheus-community.github.io/helm-charts"` | no |

## Outputs

No output.
<!--- END_TF_DOCS --->
