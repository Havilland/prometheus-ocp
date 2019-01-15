Role Name
=========

This role deploys a customized prometheus-operator to work alongside the cluster-monitoring operator present in OpenShift >= v3.10

Additionally it can be run periodically to deploy prometheus instances and corresponding grafana instances into projects with a 
specified label

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

* openshift python module
* ansible 2.7.x

Role Variables
--------------

For defaults see [`defaults/main.yaml`](defaults/main.yaml)

* `cluster_prometheus_namespace`: Namespace where to deploy prometheus operator
* `cluster_prometheus_apiGroup`: apiGroup for the prometheus-operator (don't use monitoring.coreos.com if cluster-monitoring-operator is present)
* `cluster_prometheus_operator_size`: 1
* `cluster_prometheus_operator_version`: Which version of the prometheus-operator should be deployed
* `cluster_prometheus_operator_serviceAccount`: Name of the prometheus-operator service account (currently also used for clusterrole)
* `cluster_prometheus_namespace_label`: Namespace label that determines if prometheus and grafana will be deployed
* `cluster_prometheus_namespace_serviceAccount`: prometheus service account name
* `cluster_prometheus_grafana_serviceAccount`: grafana service account name
* `cluster_prometheus_grafana_image`: Image that will be used for grafana
* `cluster_prometheus_oauth_image`: Image that will be used for oauth-proxy
* `cluster_prometheus_grafana_oauth_port`: oauth proxy port
* `cluster_prometheus_grafana_port`: grafana port
* `cluster_prometheus_grafana_memory_requests`: 100Mi
* `cluster_prometheus_grafana_memory_limit`: 200Mi
* `cluster_prometheus_grafana_cpu_requests`: 100m
* `cluster_prometheus_grafana_cpu_limit`: 200m
* `cluster_prometheus_oauth_proxy_memory_requests`: 100Mi
* `cluster_prometheus_oauth_proxy_cpu_requests`: 100m
* `cluster_prometheus_oauth_proxy_memory_limit`: 100Mi
* `cluster_prometheus_oauth_proxy_cpu_limit`: 100m
* `cluster_prometheus_grafana_storage_type`: What storage type should be used for grafana (none or pvc)

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: prometheus-ocp, cluster_prometheus_namespace: app-prometheus, cluster_prometheus_apiGroup: monitoring.example.com }

License
-------

BSD

Author Information
------------------

Alexander Bartilla (alexander.bartilla@cloudwerkstatt.com)