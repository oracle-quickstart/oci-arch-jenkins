variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "availablity_domain_name" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "label_prefix" {
  default = ""
}

variable "http_port" {
  default = 8080
}

variable "lb_http_port" {
  default = 80
}

variable "lb_https_port" {
  default = 443
}

variable "jnlp_port" {
  default = 49187
}

#variable "plugins" {
#  type        = list(string)
#  description = "A list of Jenkins plugins to install, use short names. "
#  default     = ["git", "ssh-slaves", "oracle-cloud-infrastructure-compute"]
#}

variable "plugins" {
  description = "Jenkins Plugins"
  default     = "git,ssh-slaves,oracle-cloud-infrastructure-compute"
}

variable "jenkins_version" {
  default = "2.277.4"
}

variable "jenkins_password" {
}

variable "agent_count" {
  default = "2"
}

variable "bastion_display_name" {
  default = "JenkinsBastion"
}

variable "bastion_shape" {
  default = "VM.Standard2.1"
}

variable "bastion_flex_shape_ocpus" {
  default = ""
}

variable "bastion_flex_shape_memory" {
  default = ""
}

variable "master_shape" {
  default = "VM.Standard2.4"
}

variable "master_flex_shape_ocpus" {
  default = ""
}

variable "master_flex_shape_memory" {
  default = ""
}

variable "agent_shape" {
  default = "VM.Standard2.4"
}

variable "agent_flex_shape_ocpus" {
  default = ""
}

variable "agent_flex_shape_memory" {
  default = ""
}

variable "bastion_user" {
  default = "opc"
}

variable "listener_ca_certificate" {
  default = ""
}

variable "listener_private_key" {
  default = ""
}

variable "listener_public_certificate" {
  default = ""
}

#variable "OsImage" {
#  default = "Oracle-Linux-7.8-2020.09.23-0"
#}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
}

