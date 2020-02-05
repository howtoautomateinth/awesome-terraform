# Awesome Terraform
A summarize of terraform usage and example

## Prerequisite
- [Terraform with brew](https://brewinstall.org/install-terraform-on-mac-with-brew/)

## Advantage of Terraform
- Infrastruture as Code
- Automation of your Infrastructure
- Infrastructure auditable
- Keep infrastructure in certain state

## Terraform Syntax

Terraform will interpret with *tf* extension

3 main things are
- Type
- Blocks
- Arguments

## Terraform Objects 
### Resources

> Resources are the most important element in the Terraform language

Each resource is associated with a single resource type, which determines the kind of infrastructure object

```
resource "type" "name" {
  arguments = value
}

e.g. resource type aws_instance

resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}

```

Each resource type in turn belongs to a [provider](https://www.terraform.io/docs/providers/index.html)

```
e.g. aws

provider "aws" {
  
}
```

#### Meta-Arguments 

Meta-arguments, which can be used with any resource type to change the behavior of resources

- [depends_on](https://www.terraform.io/docs/configuration/resources.html#depends_on-explicit-resource-dependencies)
  - for specifying hidden dependencies
- [count](https://www.terraform.io/docs/configuration/resources.html#count-multiple-resource-instances-by-count)
  - for creating multiple resource instances according to a count
- [for_each](https://www.terraform.io/docs/configuration/resources.html#for_each-multiple-resource-instances-defined-by-a-map-or-set-of-strings)
  - to create multiple instances according to a map, or set of strings
- [provider](https://www.terraform.io/docs/configuration/resources.html#provider-selecting-a-non-default-provider-configuration)
  - for selecting a non-default provider configuration
- [lifecycle](https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations)
  - for lifecycle customizations
- [provisioner and connection](https://www.terraform.io/docs/configuration/resources.html#provisioner-and-connection-resource-provisioners)
  - for taking extra actions after resource creation

### Variable

- Input Variable

> Input variables serve as parameters for a Terraform module

- Variable Type
  - string
  - bool
  - number
  - list
  - set
  - map
  - object
  - tuple

```
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

usage by var.<NAME>

resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = var.image_id
}
```

- Variable Definitions Files 

> To set lots of variables, it is more convenient to specify their values in a variable definitions file (either .tfvars or .tfvars.json)

```
.tfvars

image_id = "ami-abc123"
availability_zone_names = [
  "us-east-1a",
  "us-west-1c",
]

.tfvars.json

{
  "image_id": "ami-abc123",
  "availability_zone_names": ["us-west-1a", "us-west-1c"]
}

```

- Output Variable

> Output values are like the return values of a Terraform module

```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```

*Outputs are only rendered when Terraform applies your plan. Running terraform plan will not render outputs*

## Software provision with Terraform 

Two ways to provision software
- Custom AMI
- Standard AMI with 
  - File upload
  - Remote exec
  - Automation tools
    - chef (integrated with terraform)
    - puppet
    - ansible

## Built-in Functions 

> The Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values

```
> max(5, 12, 9)
12

> format("Hello, %s!", "Ander")
Hello, Ander!
> format("There are %d lights", 4)
There are 4 lights
```

All the function reference [here](https://www.terraform.io/docs/configuration/functions.html)

## Terraform Command

start with *terraform*

- init 
  - every time before do anythings
- plan
  - check infrasturcture that is going to provision
- apply
  - apply infrastructure to provider
- console
