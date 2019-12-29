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

set your own domain, because in all charts it is set to *cloud.lab*

it takes the domain as the first argument.
you can check success with e.g. grafana in the charts dir.
it will change from grafana.cloud.lab to grafana.example.com in the values.yml

`./set-domain.sh example.com`

i am using a private harbor registry, where i am downloading my docker images to the cluster.
If you want to use your own, then change harbor.cloud.lab to your linking.
If you don't have a private registry just execute the script which will remove the prefix and you will download from the internet again, no extra steps required.

`./set-registry-public.sh`

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


### access the services

you can reach the following services via ingress:

- grafana.your-domain

```
user: admin
password: password
```

- kibana.your-domain

```
user: elastic
pw: 
kubectl -n logging get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode
```
- minio.your-domain

```
accessKey: "AKIAIOSFODNN7EXAMPLE"
secretKey: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

```

- traefik.your-domain

#### services below are not reachable via ingress and only with port-forwarding

ceph manager dashboard
go to https://localhost:8443
```
kubectl -n rook-ceph port-forward svc/rook-ceph-mgr-dashboard 8443:8443
```
```
user: admin
pw:
kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo

```

prometheus server dashboard
go to http://localhost:8080
```
kubectl -n monitoring port-forward svc/prometheus-server 8080:80
```

### Contributing

all contributions are welcome