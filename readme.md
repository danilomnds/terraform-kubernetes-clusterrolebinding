# Module - Cluster role binding k8s
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of cluster role bindings in K8S environments.

## Compatibility matrix

| Module Version | Terraform Version | Kubernetes Provider Version |
|----------------|-------------------| --------------------------- |
| v1.0.0         | v1.6.4            | 2.23.0                      |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Use case for the creation of a cluster role binding for the **standard clusterrole.

The standard cluster role is created using the module [https://github.com/danilomnds/terraform-kubernetes-clusterrole](https://github.com/danilomnds/terraform-kubernetes-clusterrole)

```hcl
module "<clustername>-clusterrolebinding" {  
  source = "git::https://github.com/danilomnds/terraform-kubernetes-clusterrolebinding?ref=v2.0.0"
  subject = [{    
    name =  "<group object id>"
    kind = "Group"
    api_group = "rbac.authorization.k8s.io"
    },
    {
    name =  "<spn object id>"
    kind = "User"
    api_group = "rbac.authorization.k8s.io"
    },
    {
    name =  "<service account id>"
    kind = "ServiceAccount"
    namespace = "<namespace name>"
    }
  ]
}
```
## Use case for the creation of a cluster role binding for a customized cluster role.

```hcl
module "<clustername>-clusterrolebinding" {  
  source = "git::https://github.com/danilomnds/terraform-kubernetes-clusterrolebinding?ref=v2.0.0"
  metadata = {
    name = <clusterrolebinding-name>
  }
  role_ref = {
    name      = "custom-cluster-role-name"
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
  }
  subject = [{    
    name =  "<group object id>"
    kind = "Group"
    api_group = "rbac.authorization.k8s.io"
    },
    {
    name =  "<spn object id>"
    kind = "User"
    api_group = "rbac.authorization.k8s.io"
    },
    {
    name =  "<service account id>"
    kind = "ServiceAccount"
    namespace = "<namespace name>"
    }
  ]
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | a block as defined below | `object({})` | n/a | No |
| role_ref | a block as defined below | `list(object({}))` | n/a | No |
| subject | a block as defined below | `object({})` | n/a | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| metadata | annotations | an unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata | `map(string)` | `null` | No |
| metadata | generate_name | prefix, used by the server, to generate a unique name only if the name field has not been provided | `string` | `null` | No |
| metadata | labels | map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding | `map(string)` | `null` | No |
| metadata | name | cluster role name | `string` | `readerclusterrolebinding` | No |
| role_ref | name | the name of this clusterrole to bind subjects to | `string` | `readerclusterrole` | `Yes` |
| role_ref | api_group | the api group to drive authorization decisions | `string` | `rbac.authorization.k8s.io` | `Yes` |
| role_ref | kind | the type of binding to use | `string` | `ClusterRole` | `Yes` |
| subject | name | the name of this clusterrole to bind subjects to | `string` | n/a | `Yes` |
| subject | namespace | namespace defines the namespace of the serviceaccount to bind to | `string` | n/a | No |
| subject | kind | the type of binding to use | `string` | n/a | `Yes` |
| subject | api_group | the api group to drive authorization decisions | `string` | n/a | `Yes` |

## Documentation

Terraform kubernetes_cluster_role_binding: <br>
[https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding)<br>