# kubernetes-ingress-controller
This is a Kubernetes Ingress-Controller Service which routes requests to /footballs or /boots depending on the HTTP URL (http://soccer-world). The following software/tools have been used in this architecture - [K8s](https://kubernetes.io/), [Nginx](https://docs.nginx.com/), [HTML](https://www.w3schools.com/html), [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/) and [Ingress-Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)

## Architecture
This K8s architecture consists of one Node and two Pods using 2 Deployments , 2 ConfigMaps, 2 NodePort Services and an Ingress-Controller service for external site accessibility. The Node will reside within the Namespace `ingress-namespace` and the bulk of the configuration can be found within the `kubernetes-ingress-controller.yml`.

<img width="799" alt="image" src="https://user-images.githubusercontent.com/83971386/193860312-a5b79d82-d7b0-4124-94aa-8ae07e984620.png">

## How to Apply/Destroy
This section details the deployment and teardown of the kubernetes-simple-webapp architecture. 

## Prerequisites
* Minikube installation - [steps](https://minikube.sigs.k8s.io/docs/start/)
* Virtualbox installation - [steps](https://www.virtualbox.org/wiki/Downloads)

### Deployment steps

###	1. Clone the kubenetes-ingress-controller repo
     git clone https://github.com/BJWRD/kubernetes-ingress-controller.git

### 2. Start the minikube instance within Virtualbox
     minikube start --driver=virtualbox
     
### 3. To enable the NGINX Ingress controller
     kubectl addons enable ingress

### 4. Create the ingress-namespace using kubectl
     kubectl create -f namespace-definition.yml

### 5. Create the bulk of the Kubernetes resources (Deployment, ConfigMap, Service, Ingress-Controller)
     kubectl create -f kubernetes-ingress-controller.yml 
     
### 6. Verify the Minikube's external IP address and service list
     minikube ip
     minikube service list
<img width="738" alt="image" src="https://user-images.githubusercontent.com/83971386/193860482-5e5ca6f5-f8b8-42a7-b42c-561d1c2f49db.png">

### 7. Add the following line to the bottom of the /etc/hosts file on your computer to allow hostname (you will need sudoer permission).
      sudo vi /etc/hosts
      soccer-world  <Minikube IP>

### 8. Test site accessibility

    curl http://soccer-world/footballs && curl http://soccer-world/boots
    
- Also, try from a web browser specifying the following -

      http://soccer-world/footballs
      "Hello World! This is the Soccer-World Footballs Page!"
      
      http://soccer-world/boots
      "Hello World! This is the Soccer-World Boots Page!"

### Teardown steps

### 1. Delete the deployed K8's infrastructure
     kubectl delete -f namespace-definition.yml
     kubectl delete -f kubernetes-ingress-controller.yml
    
### 2.  Delete the running minikube instance
     minikube delete

## List of tools/services used
* [Minikube](https://minikube.sigs.k8s.io/docs/)
* [K8s Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/)
* [Services- NodePort](https://kubernetes.io/docs/concepts/services-networking/service/)
* [Ingress-Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
* [Nginx](https://docs.nginx.com/)
* [HTML](https://www.w3schools.com/html/)
* [Draw.io](https://www.draw.io/index.html)
