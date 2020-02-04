# Awesome Terraform
A summarize of terraform usage and example

## Prerequisite
- [Terraform with Brew](https://brewinstall.org/install-terraform-on-mac-with-brew/)

## Advantage of Terraform
- Infrastruture as Code
- Automation of your Infrastructure
- Infrastructure auditable
- Keep infrastructure in certain state

## Terraform Syntax

Terraform will interpret with *tf* extension

3 main things are
- Type
  - string
  - bool
  - number
  - list
  - set
  - map
  - object
  - tuple
- Blocks
- Arguments

### Variable

- Input Variable

```
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}
```

### Resources
describes infrastructure objects

```
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}
```

## Terraform Command

start with *terraform*

- console
- plan
