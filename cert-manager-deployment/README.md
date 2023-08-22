# cert-manager-deployment
The following steps detail the End-to-end Cert-Manager configuration process -

#### 1.	Clone the repo
    git clone https://github.com/BJWRD/Kubernetes/cert-manager-deployment && cd cert-manager-deployment

#### 2. Creating the ca.crt & ca.key files

        openssl genrsa -out ca.key 4096

        openssl req -new -x509 -sha256 -key ca.key -out ca.crt

#### 3. Creating a CA tailored Secret 
Create the following kubernetes secret -

         kubectl create -f ca-secret.yaml

#### 4. Creating a ClusterIssuer Resource

#### 5. Creating Kubernetes Certificate Resources

#### 6. Adding the ca.crt to your Trusted Root Certification Authority

#### 7. Verification 

### Useful Resources:
CA - cert-manager - https://cert-manager.io/docs/configuration/ca/
Securing Ingress Resources - https://cert-manager.io/docs/usage/ingress/
