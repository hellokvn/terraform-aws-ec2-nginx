output "ec2_public_dns" {
  value = aws_instance.node.public_dns
}

output "ec2_public_ip" {
  value = aws_eip.eip.public_ip
}