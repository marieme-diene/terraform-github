variable "region" {
  default = "us-west-1"
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
  default = "ami-038bba9a164eb3dc1"  # Ubuntu 22.04 LTS for us-west-1
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
