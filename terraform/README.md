# AWS Native Resource Management using Terraform

## AWS Setup

1. AWS Account
2. Create IAM user
3. Attach managed policy - `AdministratorAccess` to the IAM user
3. Create AWS Credentials for the IAM user in step 2
4. Setup AWS CLI with IAM user credentials from step 3

## Terraform Setup

1. Install `terraform` by following instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Module Description

The scripts in this folder creates Github OIDC Provider for AWS.
As then name suggests, the provider is used on Github as part of Github Actions.
The purpose of the provider is to provide a secure way of performing actions against the AWS account for provisioning AWS native resources.

## Module Folder Structure

```
├── dev                            # Environment specific infra resources
│   ├── 01_github_oidc_provider.tf # Uses modules to create resources
│   ├── files
│   │   └── github_oidc_s3_policy.json
├── modules                        # Reusable modules
│   └── github_oidc_provider       # module name
│       ├── inputs.tf              # input variables for the module
│       ├── main.tf                # actions performed by the module
│       └── outputs.tf             # output variables for the module
```



