output "jump_host_public_ip" {
  value = module.jump_host.public_ip
}

output "private_ec2_private_ips" {
  value = [for i in module.private_ec2 : i.private_ip]
}
