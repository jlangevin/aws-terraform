# This example repo uses Terraform cloud to validate files, using a `remote` backend.
terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "langevin-io"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "aws-terraform-example-repo"
    }
  }
}
