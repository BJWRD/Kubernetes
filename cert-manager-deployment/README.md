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
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.crds.yaml
    
### Configure Cert-Manager and the required certificate resources
#### 1.	Clone the repo
    git clone https://github.com/BJWRD/Kubernetes && cd cert-manager-deployment

#### 2. Creating the ca.crt & ca.key files

**Windows** -

    openssl genrsa -out ca.key 4096

    openssl req -new -x509 -sha256 -key ca.key -out ca.crt

**MacOS** -
    
    sed -i '/\[ v3_ca \]/a basicConstraints = critical,CA:TRUE\nsubjectKeyIdentifier = hash\nauthorityKeyIdentifier = keyid:always,issuer:always' /etc/ssl/openssl.cnf

    openssl genrsa -out ca.key 4096

    openssl req -new -x509 -sha256 -key ca.key -out ca.crt -extensions v3_ca

Populate the certificate with the relevant information.

#### 3. Creating a CA tailored Secret 
    
    kubectl create ns cert-manager

Encode the `ca.crt` -

    cat ca.crt | base64

Copy contents to the `ca-secret.yaml` file 
Then encode the `ca.key` - 

    cat ca.key | base64
    
And like the `ca.crt` you will need to enter the encoded `ca.key` contents within the `ca-secret.yaml`.

Your Secret YAML file should look somewhat similar to the image below -

<img width="715" alt="image" src="https://github.com/BJWRD/Kubernetes/assets/83971386/122ca05a-917e-4a1f-984e-9e900b72803e">

Finally, create the Secret using the following kubectl command -

    kubectl create -f ca-secret.yaml

Verification of the Secret creation -

<img width="382" alt="image" src="https://github.com/BJWRD/Kubernetes/assets/83971386/45f8ef1b-3493-44e7-93af-cbca65a55186">

#### 4. Creating a ClusterIssuer Resource
Create the Issuer using the following kubectl command -

    kubectl create -f ca-clusterissuer.yaml

Verification of the Issuer creation -

<img width="398" alt="image" src="https://github.com/BJWRD/Kubernetes/assets/83971386/2e3c755a-877e-4ad7-9712-49fcc354e7f4">


#### 5. Creating Kubernetes Certificate Resources
The Kubernetes Certificate resources can be created via applying the following annotation to an Ingress resource -

    cert-manager.io/cluster-issuer: ca-clusterissuer
    
#### 6. Adding the ca.crt to your Trusted Root Certification Authority
 **Windows** - 
 `Run` > `certmgr.msc` > `Trust Root Certification Authority` > `Certificates` > `Import`
 
 **MacOS** - 
`Keychain Access` > `System` > `Import Items` > `Select Certificate` > ` Open` > `Doubleclick Certificate` > `Always Trust`

#### 7. Verification 
For verification purposes to ensure the deployment/configuration process has worked. Enter the commands below -

    kubectl get certificaterequest -A
    kubectl get certificates -A

Or alternatively, access the applications via the web browser and check the certificate details.

### Useful Resources:
* CA - cert-manager - https://cert-manager.io/docs/configuration/ca/
* Securing Ingress Resources - https://cert-manager.io/docs/usage/ingress/
* MacOS OpenSSL Resource - https://github.com/cert-manager/cert-manager/issues/279
