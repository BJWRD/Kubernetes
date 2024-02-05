# grafana-prometheus-loki-deployment
The following project includes the provisioning steps of a multi-app security monitoring solution. The deployment consists of the following Helm Charts with tailored values - Grafana, Prometheus, Loki & Promtail. 

## Prerequisites
* A running EKS Cluster, whereby resources can be deployed upon.
* Route53 DNS Record - `grafana.test.com`
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
* Kubectl Installation - [steps](https://helm.sh/docs/intro/install/)
* Helm Installation - [steps](https://pwittrock.github.io/docs/tasks/tools/install-kubectl/)
* Kubeconfig Setup/Configured
* A created K8s secret resource containing AWS Credentials entered within.

## Switch to the EKS Cluster
Using the AWS CLI, ensure you select the EKS Cluster which you plan to deploy the Helm Charts to -

    aws eks update-kubeconfig --name EKS-Cluster

## Clone the Repo

    git clone https://github.com/BJWRD/Kubernetes && cd grafana-prometheus-loki-deployment

## Helm Repo Download's

    helm repo add grafana https://grafana.github.io/helm-charts

    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

## Kubernetes Secret Creation
As mentioned within the Pre-Requisites section, a Kubernetes Secret resource containing AWS Credentials (AWS Access Key & AWS Secret Key) are required for the Loki Helm Chart to then mount this secret to it's deployment. 

By implementing this secret creation and it's subsequent mounting to the Loki deployment, it ensures that the Loki logs are imported within the assigned AWS S3 bucket (referenced within the Loki Helm Chart values).

The following steps are required to achieve this -

1. Create the secret .yaml file -
   
       vi loki-secret.yaml
   
2. Update the secret .yaml file with the secret parameters

       apiVersion: v1
       kind: Secret
       metadata:
          name: loki-secret
          namespace: loki
       type: Opaque
       data:
          AWS_ACCESS_KEY_ID: 
          AWS_SECRET_ACCESS_KEY 

3. Encode your AWS Access Key and AWS Secret Key using base64

       echo -n 'Alfjase&99dhBJSIAIF/sdfjiaef' | base64

4. Copy the output values of the echo commands and append them to each respective field within the loki-secret-keys.yaml file

          apiVersion: v1
       kind: Secret
       metadata:
          name: loki-secret
          namespace: loki
       type: Opaque
       data:
          AWS_ACCESS_KEY_ID: Enter here
          AWS_SECRET_ACCESS_KEY Enter here

5. Finally, create the secret resource so it's ready prior to the Loki Helm Chart deployment -
   
        kubectl create -f loki-secret.yaml

## Helm Installation's

    helm install grafana grafana/grafana --namespace monitoring --values grafana-values.yaml

    helm install loki grafana/loki --namespace monitoring --values loki-values.yaml

    helm install promtail grafana/promtail --namespace monitoring --values promtail-values.yaml

    helm install prometheus prometheus-community/prometheus --namespace monitoring --values prometheus-values.yaml

**NOTE:** Ensure that both the `--namespace` and `--values` flags are appended to the helm installation commands.

## Deployment Review
Once the helm installations have been completed, you should then be able to access the Grafana application by entering your Grafana Ingress URL into a browser - `grafana.test.com`

You will also be able to see the majority of the deployed Kubernetes resources via the terminal using - `kubectl get all -n monitoring`

    NAME                                                    READY   STATUS    RESTARTS      AGE
    pod/loki-backend-0                                      2/2     Running   0             1h
    pod/loki-canary-s6b8l                                   1/1     Running   0             1h
    pod/loki-gateway-7968f8458c-l2s5z                       1/1     Running   0             1h
    pod/loki-grafana-agent-operator-574d44fd67-h62dm        1/1     Running   0             1h
    pod/loki-logs-2lhcc                                     2/2     Running   0             1h
    pod/loki-read-546bdc47b7-cbfvw                          1/1     Running   0             1h
    pod/loki-write-0                                        1/1     Running   0             1h
    pod/ls-monitoring-grafana-7c8b78fc59-lcbcn              1/1     Running   0             1h
    pod/prometheus-alertmanager-0                           1/1     Running   0             1h
    pod/prometheus-kube-state-metrics-d9955668-2vccg        1/1     Running   0             1h
    pod/prometheus-prometheus-node-exporter-6xqnw           1/1     Running   0             1h
    pod/prometheus-prometheus-pushgateway-cf8d5957c-zttsv   1/1     Running   0             1h
    pod/prometheus-server-78c648b864-4qsw7                  2/2     Running   0             1h
    pod/promtail-6wxpp                                      1/1     Running   0             1h

**NOTE:** The above is just an example which includes **some** of the resources which will be provisioned.

## Grafana Dashboard Importation
Access the Grafana application and work your way to the Dashboard Importation section - `Home > Dashboards > New > Import`

From here you will be able to drag and drop any of the `.json` files found within the **grafana-prometheus-loki-deployment** repository.

Just ensure that the respective/applicable datasource is selected in each importation if required i.e. Loki/Prometheus.

![image](https://github.com/BJWRD/Kubernetes/assets/83971386/3287fee6-55c9-4bc5-9f60-0323321952bd)

## Loki Dashboards

**Loki Kubernetes Logs**
![image](https://github.com/BJWRD/Kubernetes/assets/83971386/aefba208-7d36-42b6-873c-7371e7aa9557)

**Loki Log Explorer**

![image](https://github.com/BJWRD/Kubernetes/assets/83971386/45ca1fae-bf31-4c28-bf8a-ffdbfc1f59ba)

## Prometheus Dashboards

**Kubernetes Cluster**

![image](https://github.com/BJWRD/Kubernetes/assets/83971386/1c9894e5-4862-4e14-9225-22f482f98fab)

**Kubernetes Cluster Monitoring**

![image](https://github.com/BJWRD/Kubernetes/assets/83971386/c8a8374f-497b-43a3-bb0f-2619af81ba5e)

## S3 Bucket - Loki Logs Importation
Access your S3 bucket and from there you will see newly created files/directorys which will include your Loki logs.
![image](https://github.com/BJWRD/Kubernetes/assets/83971386/6ebab067-d31f-465c-ad20-decb6c3e51ab)


## Useful links -

* https://grafana.com/oss/loki/?utm_source=grafana_add_ds
* https://github.com/grafana/loki/blob/main/production/helm/loki/values.yaml
* https://github.com/grafana/helm-charts/blob/main/charts/promtail/values.yaml
* https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml
* https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml
* https://github.com/grafana/loki/issues/9143
* https://grafana.com/grafana/dashboards/?dataSource=prometheus&category=aws
  
