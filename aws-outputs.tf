# AWS outputs
output "aws_vm_private-key" {
  description = "Private Key of VM running on AWS"
  value = tls_private_key.aws_vm-key.private_key_pem 
}

locals {
  aws-ext-ip = aws_eip_association.aws-web-eip-association.public_ip 
}

output "aws-web-server-external-ip" {
  description = "Public IP of VM running on AWS"
  value = local.aws-ext-ip
}

