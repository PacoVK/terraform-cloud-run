terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  backend "remote" {
    organization = "pascaleuhus"

    workspaces {
      name = "Demo"
    }
  }
}

locals {
  project = var.project_id
}

provider "google" {
  project = local.project
  region  = "europe-west3"
  zone    = "europe-west3-a"
}

data "google_client_config" "current" {}

resource "google_container_registry" "registry" {
  project  = data.google_client_config.current.project
  location = "EU"
}

/*
 cannot set specific PORT, we need to use default 8080
 https://github.com/hashicorp/terraform-provider-google/issues/5539
*/
resource "google_cloud_run_service" "default" {
  name     = "deno-cloudrun"
  location = data.google_client_config.current.region

  template {
    spec {
      containers {
        image = format("eu.gcr.io/%s/deno-oak:%s", data.google_client_config.current.project, var.app_version)
      }
    }
  }
}

/*
  Make service public available
*/
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

/*
 To be able to deploy from CI/CD pipeline
*/
resource "google_service_account" "github_sa" {
  account_id   = "registry"
  description  = "GitHub"
  display_name = "GitHub SA"
}

resource "google_storage_bucket_iam_binding" "binding" {
  role   = "roles/storage.admin"
  bucket = google_container_registry.registry.id
  members = [
    format("serviceAccount:%s", google_service_account.github_sa.email)
  ]
}

output "api_url" {
  value = google_cloud_run_service.default.status.0.url
}
