
variable "repo" {
        description = "Prometheus Operator Repository"
        type = string
        default = "https://prometheus-community.github.io/helm-charts"
}
variable "grafana" {
        description = "Add grafana plugin"
        type = bool
        default = "true"
}
variable "prometheus_chart" {
        description = "Name of Prometheus chart"
        type = string
        default = "kube-prometheus-stack"
}
variable "chart_version" {
        description = "Version on Chart"
        type = string
        default = "9.4.8"
}
variable "prometheus_issuer"{
        description = "Issure to use for Prometheus"
        type = string
}


variable "prometheus_host"{
        description = "Prometheus host"
        type = string
}

variable "prometheus_cert"{
        description = "Certifcate name (secret)"
        type = string
}

variable "alertmanager_smtp_smarthost"{
        description = "Alertmanager SMTP Smarthost"
        type = string
}

variable "alertmanager_from"{
        description = "From Address for alermanager"
        type = string
}
variable "alertmanager_receiver_name"{
        description = "List of name for Alertmanager receiver"
        type = string
}

variable "alertmanager_to_email"{
        description = "List of Adresses to sed alerts to"
        type = string
}

variable "alertmanager_cert"{
        description = "Name of Alertmanager certificate"
        type = string
}

variable "alertmanager_host"{
        description = "Alertmanager Host"
        type = string
}

variable "grafana_host"{
        description = "grafana host"
        type = string
}

variable "grafana_cert"{
        description = "grafana cert"
        type = string
}

variable "domain"{
        description = "Domain used"
        type = string
}

#variable ""{
#        description = ""
#        type = 
#}
