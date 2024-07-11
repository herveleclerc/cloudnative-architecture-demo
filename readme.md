# Cloud Native Architecture

This repo is the resources for the blog post : https://blog.alterway.fr

## Proof of Concept

Main Goal: Deploy a multi-tenant oriented kubernetes cluster based on Clastix/Capsule in cloud native mode.

Tools Used: 
- **Crossplane**: Crossplane is a cloud-native control plane framework for managing infrastructure and applications across multiple cloud providers.
- **Argo Workflow**: Argo Workflow is a Kubernetes-native workflow engine for orchestrating parallel jobs and complex, multi-step tasks.
- **Clastix/Capsule**: Capsule is a Kubernetes operator that enables multi-tenancy and namespace-as-a-service capabilities in Kubernetes clusters.
- **kluctl** : Kluctl is a GitOps-focused deployment tool for Kubernetes that emphasizes simplicity and declarative configurations.

Tasks: 

- Create Microsoft Entra resources to activate Azure Entra Authentification on kubernetes
  - Users
  - Groups
  - Role Assignment
  - Group members
- Create Microsoft resources
  - Resource Group
  - Virtual Network
  - Subnets
  - AKS cluster 
- Deploy kubernetes resources et helm charts
  - namespaces
  - helm chart capsule and capsule-proxy

![argo wf](media/wf.png)


## Tricks

kubectl -n argo exec argo-workflows-server-XXXXXXXX -- argo auth token