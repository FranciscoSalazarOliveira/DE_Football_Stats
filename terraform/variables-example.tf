# Geral
variable "gcp_project_id" {
  type = string
  default = "project_id"
}


# GCP Storage
variable "bucket_name" {
  type = string
  default = "bucket_name"
}
variable "bucket_location" {
  type = string
  default = "US"
}
variable "bucket_storage_class" {
  type = string
  default = "STANDARD"
}


# GCP BigQuery
variable "bq_dataset_id" {
  type = string
  default = "dataset_name"
}
variable "bq_location" {
  type = string
  default = "US"
}