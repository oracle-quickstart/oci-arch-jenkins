## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {

  # Network Locals #

  // contains bastion, LB, and anything internet-facing
  dmz_tier_prefix = cidrsubnet(var.vcn_cidr, 2, 0)

  // contains private subnets with app logic
  app_tier_prefix = cidrsubnet(var.vcn_cidr, 2, 1)

  lb_subnet_prefix      = cidrsubnet(local.dmz_tier_prefix, 2, 0)
  bastion_subnet_prefix = cidrsubnet(local.dmz_tier_prefix, 2, 1)
  master_subnet_prefix  = cidrsubnet(local.app_tier_prefix, 2, 0)
  agent_subnet_prefix   = cidrsubnet(local.app_tier_prefix, 2, 1)


  # Compute Locals #

  # ------------------------------------------------------------------------------
  # Bastion Host Locals
  # ------------------------------------------------------------------------------
  bastion_shape             = var.bastion_shape
  bastion_flex_shape_ocpus  = var.bastion_flex_shape_ocpus
  bastion_flex_shape_memory = var.bastion_flex_shape_memory
  bastion_is_flex_shape     = length(regexall("Flex", local.bastion_shape)) > 0 ? [1] : []


  # ------------------------------------------------------------------------------
  # Master Host Locals
  # ------------------------------------------------------------------------------
  master_shape             = var.master_shape
  master_flex_shape_ocpus  = var.master_flex_shape_ocpus
  master_flex_shape_memory = var.master_flex_shape_memory


  # ------------------------------------------------------------------------------
  # Agent Host Locals
  # ------------------------------------------------------------------------------
  agent_shape             = var.agent_shape
  agent_flex_shape_ocpus  = var.agent_flex_shape_ocpus
  agent_flex_shape_memory = var.agent_flex_shape_memory


}