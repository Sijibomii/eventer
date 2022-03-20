## Before terrafoam apply
### Change workspace in order to create two cluster. 
one prod and pre-prod


Tutorial link: https://learn.hashicorp.com/tutorials/terraform/gke
## CONFIGURE KUBECTL
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)