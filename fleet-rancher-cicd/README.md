# fleet-rancher-cicd
The following project includes the deployment of a web application via a Fleet GitOps CICD solution.

## Prerequisites
* Minikube installation - [steps](https://minikube.sigs.k8s.io/docs/start/)
* Docker installation - [steps](https://docs.docker.com/desktop/install/mac-install/) 

**NOTE:** the following installation/steps were performed on MacOS.

## Minikube Cluster 

### 1. Start Minikube Cluster

      minikube start --driver=docker

## Docker Rancher Container 

### 1. Running the Rancher Container
If you are installing Rancher for learning purposes and therefore identity verification isn't a concern, run Rancher via Docker using a self-signed certificate by entering the following command -

      docker run -d --restart=unless-stopped \
      -p 80:80 -p 443:443 \
      --privileged \
      rancher/rancher:latest
      
This command will run a Rancher container on port 80 and 443.

<img width="563" alt="image" src="https://user-images.githubusercontent.com/83971386/214293091-0631c666-bdaf-4a50-9f78-52e3544cbe7c.png">

## Accessing Rancher 

### 1. Access the Rancher webpage

 To access the Rancher site, type and search your IP address followed by port 443 into your browser -
 
 Upon the first run you will be asked to enter the following command to retrieve the auto-generated bootstrap password -
 
      docker logs  container-id  2>&1 | grep "Bootstrap Password:"
 
![image](https://user-images.githubusercontent.com/83971386/214004856-0a146f17-2363-4c13-8ef2-1c783786a815.png)
 
 ### 2. Setting your own password
 You will then be prompted to set your own password for access to Rancher -
 
![image](https://user-images.githubusercontent.com/83971386/214005286-8465807a-abe0-410e-a1cd-aa90e159811e.png)

Once completed you will then be signed into the Rancher Dashboard -

<img width="580" alt="image" src="https://user-images.githubusercontent.com/83971386/216151053-a4967d15-5a77-4006-8c3e-4a925ae151d7.png">

 
## Fleet Configuration

### 1. Creating a Workspace

Select the three vertical lines in the top-left of the dashboard, followed by the `Continous Delivery` option.

<img width="229" alt="image" src="https://user-images.githubusercontent.com/83971386/216150978-83815d53-0b89-49ce-9cbe-cfad9308abcf.png">

Click on the `Advanced` button drop-down and then the `Workspaces` option -

<img width="249" alt="image" src="https://user-images.githubusercontent.com/83971386/216152091-b15cbbae-225b-4825-b5fc-93ffb0f3553e.png">

By default your current Workspace will be set to `fleet-default`. Select the `Create` button and then fill out the relevant fields -

<img width="641" alt="image" src="https://user-images.githubusercontent.com/83971386/216154013-907a05ba-f943-4157-9984-62c0a1ab9e50.png">

Your new Workspace can then be selected and assigned from the top-right dropdown -

<img width="216" alt="image" src="https://user-images.githubusercontent.com/83971386/216155061-a4983e59-d05b-4a96-8fdf-3c45675f241a.png">

### 2. Changing Cluster Workspace

Before switching to your newly created Workspace, select the `fleet-local` Workspace and click on the `Clusters` option from the left navigation bar.

Then highlight your local Cluster, click on the three vertical dots to the far-right and select `Change workspace` -

<img width="651" alt="image" src="https://user-images.githubusercontent.com/83971386/216159708-eb66f838-b4c6-47b0-847d-d29e64756c18.png">

Once selected you will then need to assign the Cluster to your new Workspace

<img width="402" alt="image" src="https://user-images.githubusercontent.com/83971386/216161144-86add9bc-5a60-4ac3-b3de-a511f073b377.png">

TBC - Create workspace group

<img width="534" alt="image" src="https://user-images.githubusercontent.com/83971386/216165246-3e398a96-b15f-4820-88bc-d8047b0a6ee7.png">


### 2. Adding your Git Repository

Click on `Gitrepos` on the navigation bar 
<img width="756" alt="image" src="https://user-images.githubusercontent.com/83971386/216155301-bf24de39-7d09-4907-8978-0c3c80c3a42a.png">

Fill out the following Git Repo creation form and select Next -

<img width="632" alt="image" src="https://user-images.githubusercontent.com/83971386/216156323-940b610d-b3a8-4694-8638-20f9920583b4.png">


## List of tools/services used
* [Minikube](https://minikube.sigs.k8s.io/docs/)
* [Docker](https://docs.docker.com/get-started/overview/)
* [K8s Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Rancher](https://ranchermanager.docs.rancher.com/)
* [Fleet](https://fleet.rancher.io)

## Useful Links -
* https://fleet.rancher.io
* https://ranchermanager.docs.rancher.com/v2.5/how-to-guides/new-user-guides/deploy-apps-across-clusters/fleet

