#!/bin/bash

#Start Minikube instance 
echo "minikube start --driver=hyperkit"
minikube start --driver=hyperkit

#Enable Minikube Ingress addon
echo "minikube addons enable ingress"
minikube addons enable ingress

#Create the required Keycloak Service and Deployment
echo "kubectl create -f namespace.yaml"
kubectl create -f namespace.yaml
echo "kubectl create -f service.yaml"
kubectl create -f service.yaml
echo "kubectl create -f deployment.yaml"
kubectl create -f deployment.yaml

#Substitute Minikube IP within the Ingress.yaml file 
echo "sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" ingress-example.yaml > ingress.yaml"
sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" ingress-example.yaml > ingress.yaml

echo "sleep 10"
sleep 10

#Create the Keycloak Ingress service
echo "kubectl create -f ingress.yaml"
kubectl create -f ingress.yaml

