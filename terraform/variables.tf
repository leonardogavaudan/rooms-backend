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

variable "rds_cluster_identifier" {
  description = "The name of the cluster"
  type        = string
  default     = "rooms-cluster"
}

variable "rds_cluster_master_username" {
  description = "The username for the master DB user"
  type        = string
  default     = "admin"
}