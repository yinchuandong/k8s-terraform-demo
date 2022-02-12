locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  stage            = local.environment_vars.locals.environment
}

terraform {
  source = "../../../modules//k8s"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  stage = local.stage
  exposed_service_node_port = 30202
}