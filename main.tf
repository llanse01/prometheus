
resource "helm_release" "prometheus_operator" {
  name  = "prometheus"
  chart = var.prometheus_chart
  repository = var.repo
  namespace = "monitoring"
  skip_crds = "false"
  create_namespace = "true"
  values = [
    templatefile("${path.module}/template/values.tpl", {
      prometheus_issuer                               = var.prometheus_issuer
      prometheus_host                                 = "prometheus.${var.domain}"
      prometheus_cert                                 = var.prometheus_cert
      alertmanager_smtp_smarthost                     = var.alertmanager_smtp_smarthost
      alertmanager_from                               = var.alertmanager_from
      alertmanager_receiver_name                      = var.alertmanager_receiver_name
      alertmanager_to_email                           = var.alertmanager_to_email
      alertmanager_cert                               = var.alertmanager_cert
      alertmanager_host                               = "alertmanager.${var.domain}"
      grafana_host                                    = "grafana.${var.domain}"
      grafana_cert                                    = var.grafana_cert
    })
  ]



 
}