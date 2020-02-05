variable "myvar" {
  type = string
  default = "hello world"
  description = "first variable on terraform"
}

variable "mylist" {
  type = list(string)
  default = [1,2,3]
}

variable "mymap" {
  type = map(string)
  default = {
      mykey = "my value"
  }
}

variable "AWS_ACCESS_KEY" {
  
}

variable "AWS_SECRET_KEY" {
  
}

variable "AWS_REGION" {
  default = "eu-west-1"
}
