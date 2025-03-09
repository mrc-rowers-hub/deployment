# Deployment to Production using Terraform 

## Prerequisites
Before you can use this Terraform configuration, ensure you have the following:

* Terraform installed on your local machine.
* AWS CLI configured with appropriate access to create resources in AWS.

Steps:
1. rds terraform
2. ecr terraform
3. deploy_to_ecr.sh (`chmod +x deploy_to_ecr.sh` & `./deploy_to_ecr.sh`
   )
4. terraform apply in ecs