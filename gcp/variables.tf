variable "GOOGLE_CREDENTIALS" {
  description = "Needs to be present to suppress TF warning of unused vars"
}

variable "project_id" {
  description = "Target project_ID"
}

variable "app_version" {
  description = "Version to deploy"
  default     = "latest"
}
