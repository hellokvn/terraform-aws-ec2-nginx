# Get Availability Zones
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem"
  }
}

# Create a EC2 Instance (Ubuntu 20)
resource "aws_instance" "node" {
  instance_type           = "t2.small"
  ami                     = "ami-0d527b8c289b4af7f"
  key_name                = aws_key_pair.key_pair.id
  vpc_security_group_ids  = [var.public_sg]
  subnet_id               = var.public_subnet

  tags = {
    Name = "TF Generated EC2"
  }

  user_data = file("${path.root}/ec2/userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}

# Create and assosiate an Elastic IP
resource "aws_eip" "eip" {
  instance = aws_instance.node.id
}
