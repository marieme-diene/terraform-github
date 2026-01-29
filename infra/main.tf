provider "aws" {
  region            = var.region
  access_key        = var.access_key
  secret_key = var.secret_access_key
}

data "aws_ami" "ubuntu_2204" {
  count       = var.ami != "" ? 0 : 1
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "ec2_demo" {
  ami           = var.ami != "" ? var.ami : data.aws_ami.ubuntu_2204[0].id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
    Env  = var.instance_env
  }
}
