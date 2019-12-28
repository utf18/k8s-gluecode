# k8s-gluecode

this repo will install the services below on top of a running kubernetes cluster from helm templates and kustomize overlays

it glues together helm and kustomize with bash.

### services:
- metallb
- traefik
- prometheus
- grafana
- kibana
- elasticsearch
- filebeat
- metrics-server
- kube-state-metrics
- rook with ceph as persistence
- minio
- falco

to be added in the future:
- istio
- vault or different password store

## prerequisites
- kubectl min 1.14 because of kustomize integration
- helm
- kubeconfig from target cluster

## getting started

create the namespaces in the cluster

`cd deployments`

`./create-namespaces.sh`

set your own domain, because in all charts it is set to *my-domain*

it takes the domain as the first argument.
you can check success with e.g. grafana in the charts dir.
it will change from grafana.my-domain to grafana.example.com in the values.yml

`./set-domain.sh example.com`

set the dhcp range for the metallb cluster in the file charts/metallb/values.yml on line: 26 and point the A-records or a wildcard to the adresses you specified in your router/firewall.

### deploy the cluster services

create rook persistence

`./deploy-rook.sh`

create the elasticsearch cluster

`./deploy-eck.sh`

create the other deployments from helm template.

the script will create the *charts-templated* folder and the subdirectories for you

`./create-helm-templates.sh`

deploy them with

`./deploy-charts.sh`



### Contributing

all contributions are welcome