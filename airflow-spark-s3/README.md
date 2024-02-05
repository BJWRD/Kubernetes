# airflow-sparks-s3
The following project includes the provisioning steps of a Airflow/Spark/S3 deployment. It will consist of the Helm Charts/DAGS/Dockefiles/Python Scripts.

## Prerequisites
* A running EKS Cluster, whereby resources can be deployed upon.
* Route53 DNS Record - `airflow.test.com` & `spark.test.com`
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
* Kubectl Installation - [steps](https://helm.sh/docs/intro/install/)
* Helm Installation - [steps](https://pwittrock.github.io/docs/tasks/tools/install-kubectl/)
* Kubeconfig Setup/Configured

## Switch to the EKS Cluster
Using the AWS CLI, ensure you select the EKS Cluster which you plan to deploy the Helm Charts to -

    aws eks update-kubeconfig --name EKS-Cluster

## Clone the Repo

    git clone https://github.com/BJWRD/Kubernetes && cd airflow-spark-s3

## Helm Repo Download's

    helm repo add 

    helm repo add 

## Kubernetes Secret Creations

## Helm Installation's

    helm install airflow *** --namespace airflow-spark --values airflow-values.yaml

    helm install spark *** --namespace airflow-spark --values spark-values.yaml

**NOTE:** Ensure that both the `--namespace` and `--values` flags are appended to the helm installation commands.

## Deployment Review
Once the helm installations have been completed, 

You will also be able to see the majority of the deployed Kubernetes resources via the terminal using - `kubectl get all -n airflow-spark`

TBC

**NOTE:** The above is just an example which includes **some** of the resources which will be provisioned.


## S3 Bucket - Airflow DAG Logs Importation



## Note: 
If you prefer to conduct the following deployment in a more automated way, this can be done so using my `airflow-spark-eks-cluster` terraform repository - TBC
  
