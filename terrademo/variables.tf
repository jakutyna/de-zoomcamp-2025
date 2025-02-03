variable "project" {
  description = "Project"
  default     = "terraform-demo-449409"
}

variable "region" {
  description = "Project Region"
  default     = "europe-central2"
}

variable "location" {
  description = "Project Location"
  default     = "EUROPE-CENTRAL2"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-demo-449409-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
