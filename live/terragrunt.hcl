# Generate an k8s provider block. You can run `minikube ip` to get the local ip address.
# And run `minikube config view` to get the certificates and key
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = "2.8.0"
        }
      }
    }

    provider "kubernetes" {
      host                   = "https://172.16.58.128:8443"
      client_certificate     = file("~/.minikube/profiles/minikube/client.crt")
      client_key             = file("~/.minikube/profiles/minikube/client.key")
      cluster_ca_certificate = file("~/.minikube/ca.crt")
    }
EOF
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${get_original_terragrunt_dir()}/terraform.tfstate"
  }
}

