

provider "google" {
  project = var.gcp_project_id
}


# GCS Bucket
resource "google_storage_bucket" "my_bucket" {
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = var.bucket_storage_class
}

# BigQuery Dataset
resource "google_bigquery_dataset" "my_dataset" {
  dataset_id    = var.bq_dataset_id
  location      = var.bq_location
  friendly_name = "Meu Dataset"
  description   = "This is my BigQuery dataset."
}