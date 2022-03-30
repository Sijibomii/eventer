// Provided at runtime

variable "credentials_path" {
    type = string
    description = "Service account json file"
}

variable "project" {
    type = string
    description = "The project ID to deploy to"
}

variable "region" {
    type = string
    description = "GCP region"
}

variable "zone" {
    type = string
    description = "The primary zone where the bastion host will live"
}

variable "ssh_user" {
    type = string
    description = "SSH username"
}

variable "ssh_public_key" {
    type = string
    description = "SSH public key file path"
}

// Default values

variable "network_name" {
  type = string
  description = "Network name"
  default     = "elk-management"
}

variable "elk-public_subnets_count" {
  type = number
  description = "Number of public subnets"
  default = 2
}

variable "elk-private_subnets_count" {
  type = number
  description = "Number of private subnets"
  default = 2
}

variable "bastion_machine_type" {
    type = string
    description = "Instance type for the Bastion host"
    default = "f1-micro"
}

variable "bastion_machine_image" {
    type = string
    description = "Machine image for bastion host"
    default = "centos-8-v20200316"
}

variable "kibana_machine_type" {
    type = string
    description = "Instance type for the Jenkins host"
    default = "n1-standard-1"
}

variable "kibana_machine_image" {
    type = string
    description = "Machine image for jenkins host"
    default = "kibana-img"
}

variable "logstash_machine_type" {
    type = string
    description = "Instance type for the worker host"
    default = "n1-standard-1"
}

variable "logstash_machine_image" {
    type = string
    description = "Machine image for worker host"
    default = "logstash-img"
}

variable "elastic_search_machine_type" {
    type = string
    description = "Instance type for the worker host"
    default = "n1-standard-1"
}

variable "elastic_search_machine_image" {
    type = string
    description = "Machine image for worker host"
    default = "elastic-search-img"
}