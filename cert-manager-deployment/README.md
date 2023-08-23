# cert-manager-deployment
The following steps detail the end-to-end Cert-Manager deployment/configuration process -

### Pre-Requisites:
* Have a running Kubernetes Cluster, whereby resources can be deployed upon.
* Ensure an Application which uses Ingress is installed and is running on the Kubernetes Cluster.
* Helm installation - [steps](https://helm.sh/docs/intro/quickstart/)

### Install Cert-Manager Helm Chart
#### 1. Add cert-manager Helm Repository
    helm repo add cert-manager https://charts.jetstack.io

#### 2. Install cert-manager 
    helm install my-cert-manager cert-manager/cert-manager
    
### Configure Cert-Manager and the required certificate resources
#### 1.	Clone the repo
    git clone https://github.com/BJWRD/Kubernetes/cert-manager-deployment && cd cert-manager-deployment

#### 2. Creating the ca.crt & ca.key files
    openssl genrsa -out ca.key 4096

    openssl req -new -x509 -sha256 -key ca.key -out ca.crt

#### 3. Creating a CA tailored Secret 
Create the following kubernetes secret -

    kubectl create -f ca-secret.yaml

Encode the `ca.crt` -

    cat ca.crt | base64 -w 0

Copy contents to the `ca-secret.yaml` file 
Then encode the `ca.key` - 

    cat ca.key | base64 -w 0
    
And like the `ca.crt` you will need to enter the encoded `ca.key` contents within the `ca-secret.yaml`.

Your Secret YAML file should look similar to the image below -

Enter Image

Finally, create the Secret using the following kubectl command -

    kubectl create -f ca-secret.yaml

Verification of the Secret creation -

Enter Image

#### 4. Creating a ClusterIssuer Resource
Create the Issuer using the following kubectl command -

    kubectl create -f ca-clusterissuer.yaml

Verification of the Issuer creation -

Enter Image

#### 5. Creating Kubernetes Certificate Resources
The Kubernetes Certificate resources can be created via applying the following annotation to an Ingress resource -

    cert-manager.io/cluster-issuer: ca-clusterissuer
    
#### 6. Adding the ca.crt to your Trusted Root Certification Authority
TBC

#### 7. Verification 
For verification purposes to ensure the deployment/configuration process has worked. Enter the commands below -

    kubectl get certificaterequest -A
    kubectl get certificates -A

Enter Image

Or alternatively, access the applications via the web browser and check the certificate details -

Enter Image
### Useful Resources:
CA - cert-manager - https://cert-manager.io/docs/configuration/ca/
Securing Ingress Resources - https://cert-manager.io/docs/usage/ingress/
