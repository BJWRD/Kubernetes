# helm-wordpress-example
The following project takes you through the steps required to deploy a [Wordpress](https://wordpress.org/) site via the [Helm](https://helm.sh/) [Kubernetes](https://kubernetes.io/) Deployment tool.

There are two alternative ways of deploying the Wordpress Chart. Both methods have been detailed within the following README file -

* Deployment steps - Automated Installation/Setup 
* Deployment steps - Utilising Bitnami Wordpress Repository

## Architecture
![image](https://user-images.githubusercontent.com/83971386/208942748-439a100e-d25a-4f1e-8657-006a595548c9.png)

## How to Apply/Destroy
This section details the deployment and teardown of the kubernetes-simple-webapp architecture. 

## Prerequisites
* Minikube installation - [steps](https://minikube.sigs.k8s.io/docs/start/)
* Virtualbox installation - [steps](https://www.virtualbox.org/wiki/Downloads) 
* Hyperkit installation - [steps](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/)

## Helm Installation

### 1. Helm Install
Enter the following commands to install Helm -

    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    
Source: [Helm Installation Documentation](https://helm.sh/docs/intro/install/)

### 2. Helm Version Verification
To confirm the version of Helm which you have installed, enter the following -

    helm version

<img width="384" alt="image" src="https://user-images.githubusercontent.com/83971386/209154939-a415a012-812a-46a5-91a7-31541d830724.png">

## Deployment steps - Automated Installation/Setup

###	1. Clone the helm-wordpress-example repo
     git clone https://github.com/BJWRD/helm-wordpress-example

### 2. Start the minikube instance within Virtualbox
     minikube start --driver=virtualbox

<img width="475" alt="image" src="https://user-images.githubusercontent.com/83971386/209128607-3da863f9-b5f7-47ab-909c-fee6409a3b55.png">

### 3. Helm Chart Installation
     helm install wordpress helm-wordpress-example/
     
***NOTE:*** 
* My Application name is wordpress 
* wordpress/ is the directory folder where the templates folder and the Chart.yaml file exists.
* This helm command will install the wordpress app (i.e. it will launch the wordpress/database pods and expose wordpress pod on port 80)
     
### 4. Helm verification
     helm list

### 5. Kubectl pod verification
     kubectl get all --all-namespaces
     
## Deployment steps - Utilising Bitnami Wordpress Repository

### 1. Add the Bitnami Repo to your local host
    
    helm repo add bitnami https://charts.bitnami.com/bitnami
    
### 2. Helm Chart Installation

    helm install my-release bitnami/wordpress
    
<img width="620" alt="image" src="https://user-images.githubusercontent.com/83971386/209133608-eeb25fa8-9238-401c-a210-b06050e009b6.png">

## Test Wordpress site accessibility
Now that the Kubernetes Wordpress Cluster has been deployed, it's time to test to see whether we can now access the Wordpress site.

Firstly verify the Minikube Network settings -

    minikube ip
    minikube service list
    
<img width="384" alt="image" src="https://user-images.githubusercontent.com/83971386/209134617-0ccd31a5-4cca-4dda-bf62-f48c7412d5e6.png">

Once confirmed, enter the address within a browser (http://<IP>:<Port>) and you will then be presented with the Wordpress welcome screen -

<img width="521" alt="image" src="https://user-images.githubusercontent.com/83971386/209134776-18a948ff-9a27-4a0d-95c6-0db0bcc4df23.png">

<img width="323" alt="image" src="https://user-images.githubusercontent.com/83971386/209340221-e0fd7757-b183-477a-bafd-04d2f20d8edc.png">

### Teardown steps

### 1. Delete the deployed K8's infrastructure
    helm uninstall wordpress
    
### 2.  Delete the running minikube instance
     minikube delete

## List of tools/services used
* [Minikube](https://minikube.sigs.k8s.io/docs/)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Hyperkit](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/)
* [Helm](https://helm.sh/)
* [K8s Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
* [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
