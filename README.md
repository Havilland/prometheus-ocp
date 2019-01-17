# Prometheus OCP

This role deploys a customized prometheus-operator to work alongside the cluster-monitoring operator present in OpenShift >= v3.10

Additionally it can be run periodically to deploy prometheus instances and corresponding grafana instances into projects with a specified label

## Requirements

### General

* OpenShift 3.10 or greater
* Ansible 2.7.x
* Python
* Pip

### Mac OS

On Mac OS hosts where Brew manages the Ansible install (and therefore, a Python install as a dependency), please ensure that Pip is installed in the correct location:

```bash

# ensure python is up to date
brew install python
brew unlink python
brew link python

# add pip to path (note versions may be different depending on the state of brew)
export PATH=/usr/local/Cellar/python/3.7.2_1/Frameworks/Python.framework/Versions/3.7/bin:$PATH

# install pip
mkdir tmp
cd tmp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py

# when ready, run playbook with 'correct' interpreter i.e. the one managed by brew
ansible-playbook -i hosts.inv site-install.yml -e 'ansible_python_interpreter=python3'
```

## Role Variables

For defaults see [`defaults/main.yaml`](defaults/main.yaml)

* `cluster_registry`: Image source
* `cluster_openshift_version`: The version of OpenShift we're deploying onto. Ensures we pull the right image versions
* `cluster_prometheus_namespace`: Namespace where to deploy prometheus operator
* `cluster_prometheus_apiGroup`: apiGroup for the prometheus-operator (don't use monitoring.coreos.com if cluster-monitoring-operator is present)
* `cluster_prometheus_operator_size`: 1
* `cluster_prometheus_operator_version`: Which version of the prometheus-operator should be deployed
* `cluster_prometheus_operator_serviceAccount`: Name of the prometheus-operator service account (currently also used for clusterrole)
* `cluster_prometheus_namespace_label`: Namespace label that determines if prometheus and grafana will be deployed
* `cluster_prometheus_namespace_serviceAccount`: prometheus service account name
* `cluster_prometheus_grafana_serviceAccount`: grafana service account name
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
* `cluster_prometheus_default_labelselector:`: Default label selector to be used by the Prometheus Operator to discover Custom Resources such as ServiceMonitors
* `k8s_auth_verify_ssl: true | false` : Whether or not to verify the API server's SSL certificates

## Usage

### Example Playbook

```ansible
  ---
  - hosts: jumpbox
    any_errors_fatal: true
    gather_facts: false
    roles:
      - prometheus-ocp
```

### Example Inventory

```ansible
  [jumpbox]
  localhost ansible_connection=local

  [jumpbox:vars]
  cluster_prometheus_namespace=monitoring-test
  cluster_prometheus_apiGroup=test.monitoring.com
  cluster_prometheus_namespace_serviceAccount=prometheus-test
  cluster_prometheus_grafana_serviceAccount=grafana-test
  cluster_prometheus_namespace_label="monitoring=true"
```

## License

BSD

## Author Information

Alexander Bartilla (alexander.bartilla@cloudwerkstatt.com)