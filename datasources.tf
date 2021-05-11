## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
}

data "template_file" "ad_names" {
  count = length(
    data.oci_identity_availability_domains.ad.availability_domains,
  )
  template = data.oci_identity_availability_domains.ad.availability_domains[count.index]["name"]
}

data "oci_core_vnic_attachments" "bastion_VNIC1_attach" {
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  instance_id         = oci_core_instance.JenkinsBastion.id
}

data "oci_core_vnic" "bastion_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.bastion_VNIC1_attach.vnic_attachments.0.vnic_id
}

data "oci_core_images" "master_image" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.master_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_core_images" "agent_image" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.agent_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_core_images" "bastion_image" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.bastion_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
    tenancy_id = var.tenancy_ocid

    filter {
      name   = "is_home_region"
      values = [true]
    }
}
