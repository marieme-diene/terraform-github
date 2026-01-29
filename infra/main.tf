provider "aws" {
  region            = var.region
  access_key        = var.access_key
  secret_key = var.secret_access_key
}

data "aws_ami" "ubuntu_2204" {
  count       = var.ami == "" ? 1 : 0
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

data "aws_ami" "amazon_linux_2023" {
  count       = var.ami == "amazon-linux-2023" ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-x86_64"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  ami_id = var.ami == "" ? data.aws_ami.ubuntu_2204[0].id : var.ami == "amazon-linux-2023" ? data.aws_ami.amazon_linux_2023[0].id : var.ami
}

resource "aws_instance" "ec2_demo" {
  ami           = local.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
    Env  = var.instance_env
  }
}
