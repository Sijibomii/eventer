output "elasticsearch" {
  value = google_compute_forwarding_rule.elasticsearch_forwarding_rule.ip_address
} 

output "kibana" {
  value = google_compute_forwarding_rule.kibana_forwarding_rule.ip_address
} 

output "logstash" {
  value = google_compute_forwarding_rule.logstash_forwarding_rule.ip_address
} 

output "bastion" {
  value = "${google_compute_instance.elk-bastion.network_interface.0.access_config.0.nat_ip }"
} 