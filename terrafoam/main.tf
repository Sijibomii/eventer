terraform {
  backend "gcs" {
      bucket = "eventer-backend-bucket"
      prefix = "${var.workspace}"
  }
}