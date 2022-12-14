# resource "<PROVIDER>_<TYPE>" "<NAME>" {
#  [CONFIG …]
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance" {
  name = var.name
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh_from_cidrs
  }
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = var.name
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the server"
}
output "instance_id" {
  value       = aws_instance.example.id
  description = "The ID of the server"
}