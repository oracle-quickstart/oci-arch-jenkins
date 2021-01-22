variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

locals {
  // contains bastion, LB, and anything internet-facing
  dmz_tier_prefix = cidrsubnet(var.vcn_cidr, 2, 0)

  // contains private subnets with app logic
  app_tier_prefix = cidrsubnet(var.vcn_cidr, 2, 1)

  lb_subnet_prefix      = cidrsubnet(local.dmz_tier_prefix, 2, 0)
  bastion_subnet_prefix = cidrsubnet(local.dmz_tier_prefix, 2, 1)
  master_subnet_prefix  = cidrsubnet(local.app_tier_prefix, 2, 0)
  slave_subnet_prefix   = cidrsubnet(local.app_tier_prefix, 2, 1)
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

variable "jnlp_port" {
  default = 49187
}

variable "plugins" {
  type        = list(string)
  description = "A list of Jenkins plugins to install, use short names. "
  default     = ["git", "ssh-slaves", "oracle-cloud-infrastructure-compute"]
}

variable "jenkins_version" {
#  default = "2.138.2"
  default = "2.249.1"
}

variable "jenkins_password" {
}

variable "slave_count" {
  default = "2"
}

variable "bastion_display_name" {
  default = "JenkinsBastion"
}

variable "bastion_shape" {
  default = "VM.Standard2.4"
}

variable "master_shape" {
  default = "VM.Standard2.4"
}

variable "slave_shape" {
  default = "VM.Standard2.4"
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
  default     = "7.8"
}

