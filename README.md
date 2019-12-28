# k8s-homelab
Kubernetes Cluster with kubeadm and sprinkles on top for home and lab

this repo will install services on top of a running kubernetes cluster from helm templates and kustomize overlays

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

set your own domain, because in alle charts it is set to *my-domain*
it takes the domain as the first argument
your can check e.g. with grafana in the charts dir.
it will change from grafana.my-domain to grafana.example.com

`./set-domain.sh example.com`

create rook persitence

`./deploy-rook.sh`

create the elasticsearch cluster

`./deploy-eck.sh`

create the other deployments from helm template
the script will create the *charts-templated* folder and the subdirectories for you

`./create-helm-templates.sh`

deploy the other services with

`./deploy-charts.sh`


all contributions are welcome