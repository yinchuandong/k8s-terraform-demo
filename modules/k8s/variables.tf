variable "stage" {
    description = "the stage of the current environment, such as dev, qa, staging, prod"
}

variable "exposed_service_node_port" {
    type = number
    description = "the port to expose a service to public ip"
}