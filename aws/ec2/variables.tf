variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey.ppk"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}