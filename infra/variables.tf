variable "region" {
  default = "eu-west-3"  # Paris
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_access_key" {
  type      = string
  sensitive = true
}

variable "ami" {
  type    = string
  # Vide = utilisation auto de la dernière Ubuntu 22.04 (eu-west-3). Sinon : AMI depuis https://cloud-images.ubuntu.com/locator/ec2/
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "neosoft-cheikh"
}

variable "instance_size" {
  default = "t2.micro"
}

variable "instance_env" {
  default = "Dev"
}
