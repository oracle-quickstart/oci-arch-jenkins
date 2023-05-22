# terraform-jenkins-ci-cd-oci

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-jenkins-ci-cd-oci)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-jenkins-ci-cd-oci)

Deploy a Jenkins CI/CD pipeline using Docker containers on Oracle Linux VM


## Reference Architecture 
The final reference architecture after the deployment and some key components are described below.

![Reference Architecture](https://github.com/oracle-devrel/terraform-jenkins-ci-cd-oci/blob/main/Image/Architecture.png)


## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `network-security-groups`, `subnets`, and `instances`.

- Quota to create the following resources: 1 VCN, 1 subnet, 1 Internet Gateway, 1 NAT Gateway, 2 route rules, and 1 compute instance.

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Deployment Options
The pipeline can be deployed on [Oracle Cloud Infrastructure][oci] using the below deployment options:

1. [Terraform][tf] 
2. [Resource Manager][orm_landing] by clicking the following button  [![Deploy to Oracle Cloud][magic_button]][magic_rm_stack]


## Deploy Using Oracle Resource Manager
The steps below guide you through deploying the pipeline on your tenancy using the OCI Resource Manager:

1. Download the [`jenkins-stack-configuration.zip`](https://github.com/oracle-devrel/terraform-jenkins-ci-cd-oci/releases/latest/download/jenkins-stack-configuration.zip) file.
2. [Login](https://cloud.oracle.com/resourcemanager/stacks/create) to Oracle Cloud Infrastructure to import the stack
    > `Home > Developer Services > Resource Manager > Stacks > Create Stack`
3. Upload the `jenkins-stack-configuration.zip` file that was downloaded earlier, and provide a name and description for the stack
4. Configure the stack
   1. **Jenkins username** - Provide a username for jenkins login
   2. **Jenkins password** - Provide a password for jenkins login
5. Review the information and click Create button.
   > The upload can take a few seconds, after which you will be taken to the newly created stack
6. On Stack details page, click on `Terraform Actions > Apply`

The private ssh key for the Linux VM will be displayed along with the public ip of the server on the Application Information tab.

## Deploy Using the Terraform CLI

### Clone the Repository
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-devrel/terraform-jenkins-ci-cd-oci
    cd Jenkins-CI-CD-OCI
    ls

2. Create a `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Availability Domain 
availability_domain_name = "<availability_domain_name>"

# Compartment
compartment_ocid = "<compartment_ocid>"
```

### Create the Resources
Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2022 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.  FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY. IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 


[oci]: https://cloud.oracle.com
[orm]: https://docs.cloud.oracle.com/iaas/Content/ResourceManager/Concepts/resourcemanager.htm
[tf]: https://www.terraform.io
[orm_landing]:https://www.oracle.com/cloud/systems-management/resource-manager/
[magic_button]: https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg
[magic_rm_stack]: https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/terraform-jenkins-ci-cd-oci/releases/latest/download/jenkins-stack-configuration.zip
