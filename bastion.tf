## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_bastion_bastion" "bastion-service" {
  count                        = var.use_bastion_service ? 1 : 0
  bastion_type                 = "STANDARD"
  compartment_id               = var.compartment_ocid
  target_subnet_id             = oci_core_subnet.JenkinsBastion.id
  client_cidr_block_allow_list = ["0.0.0.0/0"]
  name                         = "BastionService"
  max_session_ttl_in_seconds   = 1800
  defined_tags                 = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_instance" "JenkinsBastion" {
  count               = var.use_bastion_service ? 0 : 1
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = var.bastion_display_name
  shape               = local.bastion_shape

  dynamic "shape_config" {
    for_each = local.bastion_is_flex_shape
    content {
      ocpus         = local.bastion_flex_shape_ocpus
      memory_in_gbs = local.bastion_flex_shape_memory
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.JenkinsBastion.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  source_details {
    source_id   = lookup(data.oci_core_images.bastion_image.images[0], "id")
    source_type = "image"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
