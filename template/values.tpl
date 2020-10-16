  values:

    ###################################
    ## Values expected via overrides ##
    defaultRules:
      create: true
      rules:
        general: true
        PrometheusOperator: true
        alertmanager: true
        etcd: true
        k8s: true
        kubeApiserver: true
        kubeApiserverError: true
        kubeApiserverSlos: true
        kubePrometheusNodeAlerting: true
        kubePrometheusNodeRecording: true
        kubeScheduler: true
        kubernetesAbsent: true
        kubernetesApps: true
        kubernetesResources: true
        kubernetesStorage: true
        kubernetesSystem: true
        network: true
        node: true
        prometheus: true
        time: true
    # hosts is a valid FQDN
    prometheus:
      ingress:
        enabled: true
        annotations:
          kubernetes.io/ingress.class: nginix-ingress
          cert-manager.io/cluster-issuer: letsencrypt-acme-staging
        hosts:
          - { prometheus_host }
       # tls:
       #   - secretName: ${ prometheus_cert }
       #     hosts:
       #       - { prometheus_host }

      prometheusSpec:
        retention: 30d
        podMonitorSelector:
          matchLabels:
            lnrs.io/monitoring-platform: core-prometheus
        ruleSelector:
          matchLabels:
            lnrs.io/monitoring-platform: core-prometheus
        serviceMonitorSelector:
          matchLabels:
            lnrs.io/monitoring-platform: core-prometheus
        nodeSelector:
          beta.kubernetes.io/os: linux
        storageSpec:
          volumeClaimTemplate:
            spec:
              accessModes: ["ReadWriteOnce"]
              resources:
                requests:
                  storage: 300Gi

        resources:
          limits:
            memory: 2048Mi
          requests:
            memory: 1638Mi

    alertmanager:
      alertmanagerSpec:
        retention: 120h
        nodeSelector:
          beta.kubernetes.io/os: linux
        storage:
          volumeClaimTemplate:
            spec:
              accessModes: ["ReadWriteOnce"]
              resources:
                requests:
                  storage: 10Gi

      config:
        # Define smtp_smarthost to be used, and smtp_from as e.g smtp_smarthost: '<SMTP_SMARTHOST>:25', smtp_from: '<CLUSTER_NAME>@reedbusiness.com'
        global:
          smtp_smarthost: ${ alertmanager_smtp_smarthost }
          smtp_from: ${ alertmanager_from }
          smtp_require_tls: false
        route:
          group_by: ["namespace", "severity"]
          group_wait: 30s
          group_interval: 5m
          repeat_interval: 12h
          receiver: "null"
          routes:
            - match:
                alertname: Watchdog
              receiver: "null"
            - match:
                severity: warning
              receiver: alerts
            - match:
                severity: critical
              receiver: alerts
        receivers:
          - name: "null"
          - name: "alerts"
            # Define recepient address for alerts, e.g <CLUSTER-NAME>-ALERTS@reedbusiness.com
            email_configs:
              - to: ${ alertmanager_to_email }
      ingress:
        enabled: true
        annotations:
          kubernetes.io/ingress.class: nginix
          cert-manager.io/cluster-issuer: letsencrypt-acme-staging

        # Define hosts as - alertmanager-<CLUSTER_NAME>.<ROUTE53_DOMAIN>
        hosts: ${ alertmanager_host }

        tls:
          - secretName: ${ alertmanager_cert }
            hosts:
              - ${ alertmanager_host }
      resources:
        limits:
          memory: 120Mi
        requests:
          memory: 70Mi

    grafana:
      enabled: true
      ingress:
        enabled: true
        annotations:
           kubernetes.io/ingress.class: nginix
           cert-manager.io/cluster-issuer: letsencrypt-acme-staging

        # Define hosts as - grafana-<CLUSTER_NAME>.<ROUTE53_DOMAIN>
        hosts: ${ grafana_host }

        tls:
          - secretName: ${ grafana_cert }
            hosts:
              - { grafana_host }

      dashboardProviders:
        dashboardproviders.yaml:
          apiVersion: 1
          providers:
            - name: "iog"
              orgId: 1
              folder: "IOG"
              type: file
              disableDeletion: true
              editable: true
              options:
                path: /var/lib/grafana/dashboards/iog
      dashboards:
        iog:
          traefik:
            gnetId: 6293
            datasource: Prometheus
          logstash:
            gnetId: 2525
            datasource: Prometheus
          cluster-autoscaler:
            gnetId: 3831
            datasource: Prometheus
          velero:
            gnetId: 11055
            datasource: Prometheus
          cni-metrics:
            gnetId: 10970
            datasource: Prometheus
          cert-manager:
            gnetId: 11001
            datasource: Prometheus
      plugins:
        - grafana-piechart-panel

      resources:
        limits:
          memory: 200Mi
        requests:
          memory: 120Mi


    ##############
    ## Defaults ##

    commonLabels:
      lnrs.io/monitoring-platform: core-prometheus

    ## Disable components not visible on managed services
    kubeScheduler:
      enabled: false
    kubeControllerManager:
      enabled: false
    kubeEtcd:
      enabled: false

    prometheusOperator:
      enabled: true
      nodeSelector:
        beta.kubernetes.io/os: linux
      createCustomResource: false
      manageCrds: false

    prometheus-node-exporter:
      nodeSelector:
        beta.kubernetes.io/os: linux
      tolerations:
        - key: "ingress"
          operator: "Exists"
          effect: "NoSchedule"
        - key: "egress"
          operator: "Exists"
          effect: "NoSchedule"
