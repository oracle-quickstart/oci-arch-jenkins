## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_instance" "JenkinsBastion" {
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

# ------------------------------------------------------------------------------
# DEPLOY THE JENKINS CLUSTER
# ------------------------------------------------------------------------------
module "jenkins" {
  source                       = "github.com/oracle-quickstart/oci-jenkins"
  compartment_ocid             = var.compartment_ocid
  jenkins_version              = var.jenkins_version
  jenkins_password             = var.jenkins_password
  controller_ad                = data.template_file.ad_names[0].rendered
  controller_subnet_id         = oci_core_subnet.JenkinsControllerSubnetAD.id
  controller_image_id          = lookup(data.oci_core_images.controller_image.images[0], "id")
  controller_shape             = var.controller_shape
  controller_flex_shape_ocpus  = var.controller_flex_shape_ocpus
  controller_flex_shape_memory = var.controller_flex_shape_memory
  plugins                      = split(",", var.plugins)
  agent_count                  = var.agent_count
  agent_ads                    = data.template_file.ad_names.*.rendered
  agent_subnet_ids             = split(",", join(",", oci_core_subnet.JenkinsAgentSubnetAD.*.id))
  agent_image_id               = data.oci_core_images.agent_image.images[0].id
  agent_shape                  = var.agent_shape
  agent_flex_shape_ocpus       = var.agent_flex_shape_ocpus
  agent_flex_shape_memory      = var.agent_flex_shape_memory
  ssh_authorized_keys          = tls_private_key.public_private_key_pair.public_key_openssh
  ssh_private_key              = tls_private_key.public_private_key_pair.private_key_pem
  bastion_host                 = oci_core_instance.JenkinsBastion.public_ip
  bastion_user                 = var.bastion_user
  bastion_private_key          = tls_private_key.public_private_key_pair.private_key_pem
  http_port                    = var.http_port
}

