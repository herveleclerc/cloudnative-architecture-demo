#!/bin/bash

kubectl delete tenants --all

kubectl delete releases.helm.crossplane.io  --all
kubectl delete kubernetesclusters.containerservice.azure.upbound.io --all
kubectl delete subnet --all
kubectl delete virtualnetwork --all
kubectl delete resourcegroup --all

kubectl delete members.groups.azuread.upbound.io --all
kubectl delete roleassignments.authorization.azure.upbound.io --all

kubectl delete users --all
kubectl delete groups --all