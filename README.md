# README #

### Overview ### 

This repo is a sample for this [post]() about how to setup Terraform Cloud and GCP Cloud Run and the CI/CD integration.

### Requirements ###

This repo uses Terraform cloud, hence you must setup a workspace described [here]()
Example for CI/CD integration with GitHub Actions under `.github/workflows/build.yml`

### Terraform - Google Cloud ###

#### Create ####

```
cd gcp
terraform init
terraform apply
```

##### Output #####
Terraform will output a `api_url` to access the deployed webservice.

#### Remove ####

```
cd gcp
terraform destroy
```
:warning: the registry backup storage won't be deleted, you'll need to delete it manually
