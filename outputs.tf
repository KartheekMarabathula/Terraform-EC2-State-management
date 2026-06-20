
output "ec2_public_ip" {
  value       = { for key, instance in aws_instance.my_instance : key => instance.public_ip }
  description = "A map of instance keys to their public IP addresses."
}

output "print_message" {
    value = "kartheek Devops"
}

output "ec2_public_dns" {
  value       = { for key, instance in aws_instance.my_instance : key => instance.public_dns }
  description = "A map of instance keys to their public DNS names."
}
