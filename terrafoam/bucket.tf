resource "google_storage_bucket" "my_bucket" {
  name     = "eventer-backend-bucket"
  location = "us-central1"
  
  // Object Versioning must be enabled 
  versioning = true
}