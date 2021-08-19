## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

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
  use_bastion_service          = var.use_bastion_service
  bastion_service_id           = var.use_bastion_service ? oci_bastion_bastion.bastion-service[0].id : ""
  bastion_service_region       = var.use_bastion_service ? var.region : ""
  bastion_host                 = var.use_bastion_service ? "" : oci_core_instance.JenkinsBastion[0].public_ip
  bastion_user                 = var.use_bastion_service ? "" : var.bastion_user
  bastion_private_key          = tls_private_key.public_private_key_pair.private_key_pem
  bastion_authorized_keys      = tls_private_key.public_private_key_pair.public_key_openssh
  http_port                    = var.http_port
}


