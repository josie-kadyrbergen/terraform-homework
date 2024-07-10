provider aws {
  region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  count = 3
  associate_public_ip_address = true
  key_name = aws_key_pair.deployer.key_name
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache.sh")

  tags = {
    Name = "web-${count.index + 1}"
  }
}

output ec2 {
    value = aws_instance.web[0].public_ip
}