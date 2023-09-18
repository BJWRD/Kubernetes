# grafana-prometheus-loki-deployment
The following project includes the provisioning steps of a multi-app security monitoring solution. The deployment consists of the following Helm Charts with tailored values - Grafana, Prometheus, Loki & Promtail. 

## Prerequisites
* A running EKS Cluster, whereby resources can be deployed upon.
* Route53 DNS Record - `grafana.test.com`
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
* Kubectl Installation - [steps](https://helm.sh/docs/intro/install/)
* Helm Installation - [steps](https://pwittrock.github.io/docs/tasks/tools/install-kubectl/)

## Switch to the EKS Cluster
Using the AWS CLI, ensure you select the EKS Cluster which you plan to deploy the Helm Charts to -

    aws eks update-kubeconfig --name EKS-Cluster

## Clone the Repo

    git clone https://github.com/BJWRD/Kubernetes && cd grafana-prometheus-loki-deployment

## Helm Repo Download's

    helm repo add grafana https://grafana.github.io/helm-charts

    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

## Helm Installation's

    helm install grafana grafana/grafana --namespace monitoring --values grafana-values.yaml

    helm install loki grafana/loki --namespace monitoring --values loki-values.yaml

    helm install promtail grafana/promtail --namespace monitoring --values promtail-values.yaml

    helm install prometheus prometheus-community/prometheus --namespace monitoring --values prometheus-values.yaml

**NOTE:** Ensure that both the `--namespace` and `--values` flags are appended to the helm installation commands.

## Verfification
