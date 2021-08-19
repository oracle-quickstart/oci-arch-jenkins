## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "availablity_domain_name" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.5"
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

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "use_bastion_service" {
  default = true
}

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
  default = "VM.Standard.E3.Flex"
}

variable "bastion_flex_shape_ocpus" {
  default = 1
}

variable "bastion_flex_shape_memory" {
  default = 1
}

variable "controller_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "controller_flex_shape_ocpus" {
  default = 1
}

variable "controller_flex_shape_memory" {
  default = 15
}

variable "agent_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "agent_flex_shape_ocpus" {
  default = 1
}

variable "agent_flex_shape_memory" {
  default = 20
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

