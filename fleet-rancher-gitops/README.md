# fleet-rancher-gitops
The following project includes the deployment of a web application via a Fleet GitOps solution. The Web application will reside on Kubernetes infrastrucutre (AWS EKS).

## Architecture

## Prerequisites
* An AWS Account with an IAM user capable of creating resources – `AdminstratorAccess`
* A locally configured AWS profile for the above IAM user
* Terraform installation - [steps](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

**NOTE:** Please refer to the following rancher-terraform-eks-cluster GitHub repo with instructions with how to provide the EKS Cluster via Terraform - [steps](https://github.com/BJWRD/Terraform/edit/main/rancher-terraform-eks-cluster)

## SSH Key

### Generate an SSH Public Key
Via your local terminal, enter the following SSH Key generation command -

  ssh-keygen

Once generated go to the following directory - /root/.ssh and save the id_rsa.pub and id_rsa key contents to somewhere secure for later use. 

## AWS CodeCommit


### AWS IAM 

### Upload SSH Public Key for AWS CodeCommit

![image](https://github.com/BJWRD/Kubernetes/assets/83971386/428601c1-2167-40c7-84d2-fd51a5fdc6ca)

## Accessing Rancher 

### 1. Access the Rancher application

 
## Fleet Configuration

### 1. Adding your Git Repository

Click on `Gitrepos` on the navigation bar 
<img width="756" alt="image" src="https://user-images.githubusercontent.com/83971386/216155301-bf24de39-7d09-4907-8978-0c3c80c3a42a.png">

Populate the Git Repo with similar information as shown below. Ensure the Repository URL has been entered including the previously copied SSH Key ID and then the CodeCommit Repository URL.

Also ensure that the Private Key contents previously generated are entered.

Enter Image

**Note:** Enter a new line at the bottom of the private key entry to prevent any erroneous behaviour from occurring later on.

Select the rancher-cluster as the Target and then click on `Create`.

Enter Image

Once the Gitrepo has been created, it will then become Active and will begin deploying the CodeCommit Repo Chart to the targeted Cluster (Rancher-cluster). 

Enter Image.

When fully deployed, you should then be able to access the following application via your url - 

Enter Image


