variable "gcloud_project" {
  description = "Google Cloud Project where resources will be created"
}

variable "gcloud_zone" {
  description = "Google Cloud Zone where resources will be created"
}

variable "gcloud_cred_file" {
  description = "Path to GCloud credential file"
}

variable "name_prefix" {
  description = "Prefix to distinguish the instance"
  default = "remediation1"
}

variable "acebox_size" {
  description = "Size (machine type) of the ace-box instance"
  default     = "n2-standard-8"
}

variable "acebox_user" {
  description = "Initial user when ace-box is created"
  default     = "ace"
}

variable "acebox_password" {
  description = "Initial password when ace-box is created"
  default     = "dynatrace"
}

variable "acebox_os" {
  description = "Ubuntu version to use"
  default     = "ubuntu-minimal-1804-lts"
}

variable "private_ssh_key" {
  description = "Path of where to store private key on current module directory"
  default = "./key"
}

variable "disk_size" {
  description = "Size of disk that will be available to ace-box instance"
  default     = "60"
}
variable "environment_state" {
  description = "State of Dynatrace environment"
  default = "ENABLED"
}
variable "dt_cluster_url" {
  description = "Dynatrace cluster URL"
}

variable "dt_cluster_api_token" {
  description = "Dynatrace cluster API token"
}
variable "tutorial_progress" {
  description = "Dynatrace cluster API token"
  default = 9
}

variable "user" {
  description = "Map of lab participants"
  type = object({
    email = string
    firstName = string
    lastName = string
  })
  default = {
      email = "diego.test@dynatrace.com"
      firstName = "Diego-remediate"
      lastName = "Smith"
  }
}