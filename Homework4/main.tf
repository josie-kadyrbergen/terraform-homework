provider aws {
  region = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  count = var.instance_count
  ami = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "web instance-${count.index + 1}"
  }
}

variable region {
  description = "Provide region"
  type = string
  default = ""
}

variable key_name {
  description = "The name of the key pair"
  type = string
  default = ""
}

variable instance_count {
  description = "Provide the number of instances to create"
  type = number
  default = 1
}

variable ami_id {
  description = "Provide ami id"
  type = string
  default = ""
}

variable instance_type {
  description = "Provide instance type"
  type = string
  default = ""
}

variable availability_zone {
  description = "Provide availability zone"
  type = string
  default = ""
}