###################
### Application ###
###################
variable "app-name" {
  description = "The name of the application"
  type        = string
  default     = "rooms"
}

variable "app_domain_name" {
  description = "The domain name to use for the application"
  type        = string
  default     = "minutyrooms.com"
}

variable "api_domain_name" {
  description = "The subdomain name to use for the API"
  type        = string
  default     = "api.minutyrooms.com"
}

###########
### ECR ###
###########

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "${var.app-name}-repository"
}

###########
### ECS ###
###########

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "${var.app-name}-cluster"
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "${var.app-name}-service"
}

variable "task_definition_name" {
  description = "The name of the ECS task definition"
  type        = string
  default     = "${var.app-name}-task-definition"
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "${var.app-name}-container"
}

variable "container_port" {
  default = "80"
}

##################
### Networking ###
##################

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = [
    "10.0.0.0/24"
  ]
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = [
    "eu-west-3a",
    "eu-west-3b"
  ]
}