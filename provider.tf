## This file declare Provider block and variables required to run the template using Terraform CLI with standard user based authentication.
## Remove this file from your OCI ORM Stack as ORM will pick up these variables from the authenticated user running the ORM Stack.

############################################
# Provider
############################################
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}