# Module - Cluster role binding k8s
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of cluster role bindings in K8S environments.

## Dependency

This module depends on the module [https://dev.azure.com/timbrasil/Projeto_IaC/_git/k8s-module-clusterrole](https://dev.azure.com/timbrasil/Projeto_IaC/_git/k8s-module-clusterrole). 

The cluster role binding will point to the cluster role created by the module reffered above.

## Compatibility matrix

| Module Version | Terraform Version | Kubernetes Provider Version |
|----------------|-------------------| --------------------------- |
| v1.0.0         | v1.3.6            | 2.17.0                      |

## Specifying a version

To avoid that your code get automatically updates for the module is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can use a specific version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case for the creation of a cluster role binding for the standard cluster role.

```hcl
module "<clustername>-clusterrolebinding" {  
  source = "git::https://github.com/danilomnds/terraform-kubernetes-clusterrolebinding?ref=v1.0.0"  
  subjects = {    
    <group name> = {
      name =  "<group object id>"
      kind = "Group"
      api_group = "rbac.authorization.k8s.io"
    }
    <SPN name> = {
      name =  "<spn object id>"
      kind = "User"
      api_group = "rbac.authorization.k8s.io"
    }
    <service account name> = {
      name =  "<service account id>"
      kind = "ServiceAccount"
      namespace = "<namespace name>
    }
  }
}
```
## Use case for the creation of a cluster role binding for a customized cluster role.

```hcl
module "<clustername>-clusterrolebinding" {  
  source = "git::https://github.com/danilomnds/terraform-kubernetes-clusterrolebinding?ref=v1.0.0"  
  clusterrolename="<cluster role name>"
  clusterrolebinding = "<cluster role binding name>"
  subjects = {    
    <group name> = {
      name =  "<group id>"
      kind = "Group"
      api_group = "rbac.authorization.k8s.io"
    }
    SPN = {
      name =  "<spn id>"
      kind = "User"
      api_group = "rbac.authorization.k8s.io"
    }
    <service account name> = {
      name =  "<id of service account>"
      kind = "ServiceAccount"
      namespace = "<namespace name>
    }
  }
}
```
## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| clusterrolename | cluster role nome used to create the cluster role binding| `string` | `clusterrole-custom-tim` | No |
| clusterrolebinding | custom cluster role binding name | `string` | `clusterrolebinding-custom-tim` | No |
| subjects | user, groups or service accounts that will be associated to the role | `any` | n/a | `Yes` |

## Documentation

Terraform kubernetes_cluster_role_binding: <br>
[https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding)<br>