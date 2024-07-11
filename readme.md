# Cloud Native Architecture

This repo is the resources for the blog post : https://blog.alterway.fr

## Proof of Concept

Main Goal: Deploy a multi-tenant oriented kubernetes cluster based on Clastix/Capsule in cloud native mode.

Tools Used: 
- **Crossplane**: Crossplane is a cloud-native control plane framework for managing infrastructure and applications across multiple cloud providers.
- **Argo Workflow**: Argo Workflow is a Kubernetes-native workflow engine for orchestrating parallel jobs and complex, multi-step tasks.
- **Clastix/Capsule**: Capsule is a Kubernetes operator that enables multi-tenancy and namespace-as-a-service capabilities in Kubernetes clusters.
- **kluctl** : Kluctl is a GitOps-focused deployment tool for Kubernetes that emphasizes simplicity and declarative configurations.

                                  ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐
                                   Workflow                      ┌─────────────────────────────────────────┐     
                                  │                              │                                         │    │
                                                                 │                                         │     
                                  │               ┌───────┐  ┌───────┐           ┌───────┐ ┌───────┐       │    │
                                                  │ user  │  │ admin │           │reader │ │  aks  │       │     
                                  │               └───────┘  └───────┘           └───────┘ └───────┘       │    │
                                                      │          │                  │          │           │     
                                  │                   │          │                  │          │           │    │
                                                      │          │                  └───┬──────┘           │     
                                  │                   │          │                      │                  │    │
                                                      │          │                      │                  │     
                                  │ ┌──────────┐      │    ┌──────────┐           ┌──────────┐             │    │
                                    │          │      │    │          │           │   Role   │             │     
                                  │ │  Users   │      └────│  Groups  │───────────│Assignment│             │    │
                                    │          │           │          │           │          │             │     
                                  │ └──────────┘           └──────────┘           └──────────┘             │    │
                                          │                      │                                         │     
                                  │       │                      │                                         │    │
                                          │                      │                                         │     
                                  │       │                      │                                         │    │
                                          │     ┌──────────┐     │                                         │     
                                  │       │     │  Group   │     │                                         │    │
                                          └─────│  Member  │─────┘                                         │     
                                  │             │          │                                               │    │
                                                └──────────┘                                               │     
                                  │                                                                        │    │
                                                                                                           │     
                                  │                                                                        │    │
                                                                                                           │     
                                  │                                                                        │    │
                                        ┌──────────┐      ┌──────────┐      ┌──────────┐     ┌──────────┐  │     
                                  │     │ Resource │      │          │      │          │     │          │  │    │
                                        │  Group   ├──────┤   Vnet   │──────│  Subnet  │─────│   AKS    │──┘     
                                  │     │          │      │          │      │          │     │          │       │
                                        └──────────┘      └──────────┘      └──────────┘     └──────────┘        
                                  │                                                                │            │
                                                                                                   │             
                                  │                                                                │            │
                                                          ┌───────────────────────┬────────────────┘             
                                  │                       │                       │                             │
                                                          │                       │                              
                                  │                       │                       │                             │
                                                          │  ┌─────────┐  ┌──────────────┐     ┌─────────┐       
                                  │                       └──│ Capsule │  │Capsule-Proxy │─────│   LB    │      │
                                                             └─────────┘  └──────────────┘     └─────────┘       
                                  │                                                                             │
                                                                                                                 
                                  │                                                                             │
                                                                                                                 
                                  └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘


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

### Clean

Attention --all !

```

kubectl delete releases.helm.crossplane.io  --all
kubectl delete kubernetesclusters.containerservice.azure.upbound.io --all
kubectl delete subnet --all
kubectl delete virtualnetwork --all
kubectl delete resourcegroup --all

kubectl delete members.groups.azuread.upbound.io --all
kubectl delete roleassignments.authorization.azure.upbound.io --all

kubectl delete users --all
kubectl delete groups --all


```

### Get Argo Workflow API Token

kubectl -n argo exec argo-workflows-server-XXXXXXXX -- argo auth token