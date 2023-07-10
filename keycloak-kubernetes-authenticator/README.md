# keycloak-kubernetes-authenticator
Deploying a Keycloak Cluster using Kubernetes/Minikube/Helm

## How to Apply/Destroy
This section details the deployment and teardown of the keycloak-kubernetes-authenticator architecture. 

## Prerequisites
* Minikube installation - [steps](https://minikube.sigs.k8s.io/docs/start/)
* Virtualbox installation - [steps](https://www.virtualbox.org/wiki/Downloads) 
* Hyperkit installation - [steps](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/)
* Git installation - [steps](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Deploying Keycloak-Cluster Locally

## Deployment steps - Manual Installation/Setup

###	1. Clone the keycloak-kubernetes-authenticator repo
    git clone https://github.com/BJWRD/keycloak-kubernetes-authenticator

### 2. Start the minikube instance within Hyperkit
    minikube start --driver=hyperkit

<img width="475" alt="image" src="https://user-images.githubusercontent.com/83971386/209128607-3da863f9-b5f7-47ab-909c-fee6409a3b55.png">

### 3. Enable Minikube Ingress addon
    minikube addons enable ingress
     
### 4. Create the Keycloak Service and Deployment
    kubectl create -f namespace.yaml
    kubectl create -f service.yaml
    kubectl create -f deployment.yaml

### 5. Substitute the Minikube instance IP address within ingress.yaml file
    sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" ingress-example.yaml > ingress.yaml
     
### 6. Create the Keycloak Ingress service
    kubectl create -f ingress.yaml
     
## Deployment steps - Automated Installation/Setup

###	1. Clone the keycloak-kubernetes-authenticator repo
    git clone https://github.com/BJWRD/keycloak-kubernetes-authenticator
     
### 2. Change file permissions
    chmod 700 setup.sh

### 3. Execute the setup.sh script
    ./setup.sh
     
## Deployment steps - Helm Setup

### 1. Helm install

     curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
     chmod 700 get_helm.sh
     ./get_helm.sh
     helm version
      
<img width="575" alt="image" src="https://user-images.githubusercontent.com/83971386/209945174-0f1783e7-02e7-4d08-a1d8-e3d37662f4a4.png">
 
### 2. Add the Bitnami Repo to your local host

     helm repo add bitnami https://charts.bitnami.com/bitnami
      
### 3. Keycloak Helm Chart Installation

     helm install keycloak bitnami/keycloak
      
<img width="569" alt="image" src="https://user-images.githubusercontent.com/83971386/209944963-519a4a34-526b-42f0-88c2-568b0f99a3cf.png">

## Test Keycloak site accessibility
Now that the Kubernetes Keycloak-Cluster has been deployed, it's time to test to see whether we can now access the Keycloak Authentication system.

Firstly verify the Minikube Network settings -

    minikube ip
    minikube service list
    
<img width="384" alt="image" src="https://user-images.githubusercontent.com/83971386/209134617-0ccd31a5-4cca-4dda-bf62-f48c7412d5e6.png">

Once the IP address of the Keycloak-cluster has been confirmed, enter the address within a browser (http://<IP>:<PORT>) and you will then be presented with the following Keycloak login screen -

<img width="508" alt="image" src="https://user-images.githubusercontent.com/83971386/209945672-4cb91b68-07f9-41a4-a6a9-b5ce3394980c.png">

## System Access and Usability 

### Create a Realm
A realm in Keycloak is the equivalent of a tenant. It allows creating isolated groups of applications and users. By default there is a single realm in Keycloak called master. This is dedicated to manage Keycloak and should not be used for your own applications.

* Open the Keycloak Administration Console
* Hover the mouse over the dropdown in the top-left corner where it says master, then click on Create realm

<img width="594" alt="image" src="https://user-images.githubusercontent.com/83971386/209982170-055c65a6-e53f-4c28-979b-675b93a2cf61.png">

* Fill in the form with the following values:
* Realm name: myrealm
* Click Create

<img width="580" alt="image" src="https://user-images.githubusercontent.com/83971386/209982379-130c1ab9-0b28-410b-b3d2-393f75f2c889.png">

### Create User
Initially there are no users in a new realm.

From the Keycloak Admin Console, click *Users* (left-hand menu) and select *Create new user*

<img width="479" alt="image" src="https://user-images.githubusercontent.com/83971386/209983086-d90203f1-f087-4bee-bef8-a0b7e9a04b67.png">

Fill in the form with the required values and click *Create*:
* Username
* First Name
* Last Name

<img width="692" alt="image" src="https://user-images.githubusercontent.com/83971386/209983223-a7a71d38-9738-4844-8224-67890d8ae16e.png">

The user will need an initial password set to be able to login. To do this:

* Click Credentials (top of the page)
* Fill in the Set password form with a password
* Click ON next to Temporary to prevent having to update password on first login

<img width="374" alt="image" src="https://user-images.githubusercontent.com/83971386/209983395-6ce10577-b0c6-4283-9fd2-ffe6113ab85e.png">

### Login with Account Login
Now test your new account access using the username and password previously set to confirm your Account setup completion.

<img width="362" alt="image" src="https://user-images.githubusercontent.com/83971386/209983570-df705aa9-8262-4f29-b4df-50e17c7d46bf.png">

## Teardown steps

### 1. Delete the deployed K8's Infrastructure

     kubectl delete -f namespace.yaml
     kubectl delete -f deployment.yaml
     kubectl delete -f service.yaml
     kubectl delete -f ingress.yaml
    
### 2.  Delete the running minikube instance
     minikube delete
     
## List of tools/services used
* [Minikube](https://minikube.sigs.k8s.io/docs/)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Hyperkit](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/)
* [Keycloak](https://www.keycloak.org)

## Useful Links -
* https://www.keycloak.org/getting-started/getting-started-kube
