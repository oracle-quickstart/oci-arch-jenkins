## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "controller_private_ip" {
  value = module.jenkins.controller_private_ip
}

output "agent_private_ips" {
  value = module.jenkins.agent_private_ips
}

output "jenkins_http_login_url" {
  value = "http://${oci_load_balancer.JenkinsLB.ip_addresses[0]}:${var.lb_http_port}/"
}

output "jenkins_https_login_url" {
  value = "https://${oci_load_balancer.JenkinsLB.ip_addresses[0]}:${var.lb_https_port}/"
}


output "generated_ssh_private_key" {
  value = tls_private_key.public_private_key_pair.private_key_pem
}

output "bastion_public_ip" {
  value = data.oci_core_vnic.bastion_VNIC1.public_ip_address
}
