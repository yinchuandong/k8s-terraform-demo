# k8s Terraform Demo

## Terraform Environment setup

### Install terraform

- Use `tfenv` to control terraform version
- Use `brew install tfenv` on macOS to install `tfenv`
- Use `tfenv install 1.1.5` to install `terraform 1.1.5 version`
- Use `tfenv use 1.1.5` to switch a version 

### Install terragrunt

- Use `tgenv` to control terragrunt version
- Use `brew install tgenv` on macOS to install `tgenv`
- Use `tgenv install 0.36.1` to install `terragrunt 0.36.1 version`
- Use `tgenv use 0.36.1` to switch a version

## K8s setup

### minikube

The detailed document can be found here: [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/)

Make sure you can start
### kubectl

The detailed document can be found here: [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

## Configure file update

You will need to update `live/terragrunt.hcl` to use your own minikube cluster and authentication.

- You can update the `host` to your own ip via `minikube ip`.
- You can update the authenicaion certificates. Get your own one via `minikube config view`

```t
provider "kubernetes" {
    # Note: replace with your own configurations
    host                   = "https://172.16.58.128:8443"
    client_certificate     = file("~/.minikube/profiles/minikube/client.crt")
    client_key             = file("~/.minikube/profiles/minikube/client.key")
    cluster_ca_certificate = file("~/.minikube/ca.crt")
}

```


## Quick Start 
```sh
minikube start
minikube dashboard --url

cd live/dev/k8s
terragrunt init
terragrunt validate
terragrunt plan
terragrunt apply
```