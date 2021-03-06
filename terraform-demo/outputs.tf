

output "login_info" {
 # value = "Users without ssh key access can login with username: ${var.acebox_user}, password: ${var.acebox_password}"
 value = "Users without ssh key access can login with username provided by Dynatrace University. For the dashboard,user: admin password: dynatrace"
}

output "acebox_dashboard" {
  value = "http://dashboard.${google_compute_instance.acebox.network_interface[0].access_config[0].nat_ip}.nip.io"
}

output "acebox_ip" {
  value = "connect using: ssh -i key ${var.acebox_user}@${google_compute_instance.acebox.network_interface[0].access_config[0].nat_ip}"
}