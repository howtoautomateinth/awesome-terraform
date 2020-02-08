# Awesome Terraform
A summarize of terraform usage and example

## Advantage of Terraform
- Infrastruture as Code
- Automation of your Infrastructure
- Infrastructure auditable
- Keep infrastructure in certain state

## Prerequisite
- [Terraform with brew](https://brewinstall.org/install-terraform-on-mac-with-brew/)

## Terraform Command

start with *terraform*

- init 
  - every time before do anythings
- plan
  - check infrasturcture that is going to provision
- apply
  - apply infrastructure to provider
- console

### Note
- Terraform v0.12 now allows you to use expressions directly when defining most attributes. No need to use interpolation any more

```
 # Old 0.11 example
  tags = "${merge(map("Name", "example"), var.common_tags)}"

  # Updated 0.12 example
  tags = merge({ Name = "example" }, var.common_tags)
```

- To run an example of Terraform please provide *Terraform.tfvars* that contains AWS credentail on those folder 

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

## Control Statement
- [if-else](https://www.terraform.io/docs/configuration-0-11/interpolation.html#conditionals)

```
# condition ? true_val : false_val

resource "aws_instance" "web" {
  subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
}

```

- [loop](https://www.terraform.io/docs/configuration/expressions.html#for-expressions)
  - for
    - creates a complex type value by transforming another complex type value
  
```
# Produce tuple
[for s in var.list : upper(s)]

# Produce object
{for s in var.list : s => upper(s)}

Diff is "[" or "{"

# optional if clause to filter elements
[for s in var.list : upper(s) if s != ""]

# add ... symbol for object
{for s in var.list : substr(s, 0, 1) => s... if s != ""}
```

  - dynamic block
    - supported inside resource, data, provider, and provisioner blocks
    - acts much like a for expression
    - The for_each argument provides the complex value to iterate over
    - Best Practices for dynamic Blocks
      - Overuse of dynamic blocks can make configuration hard to read and maintain
      
```
resource "aws_security_group" "example" {
  name = "example" # can use expressions here

  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
    }
  }
}
```

## Modules

> is a container for multiple resources that are used together

To define a module, create a new directory for it and place one or more .tf files inside just as you would do for a root module. Modules can also call other modules using a *module* block (but recommend keeping flat)

### Module structure

Most commonly, modules use

- [Input Variables](https://www.terraform.io/docs/configuration/variables.html)
- [Ouput Values](https://www.terraform.io/docs/configuration/outputs.html)
- [Resources](https://www.terraform.io/docs/configuration/resources.html)

### When to write a module

Any combination of resources and other constructs can be factored out into a module, but over-using modules can make your overall Terraform configuration harder to understand and maintain, so we recommend moderation.

```
For example, aws_instance and aws_elb are both resource types belonging to the AWS provider. 
You might use a module to represent the higher-level concept "HashiCorp Consul cluster running in AWS" 
which happens to be constructed from these and other AWS provider resources.
```

### Standard Module Structure

recommend for reusable modules distributed in separate repositories

- Root module 
  - a file and directory layout
  - or have nested under Root module
- README.md

```
# Dedicated folder for module and README.md
$ tree minimal-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf

#Nested
$ tree complete-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```

## Packer

> Build Automated Machine Images

[Packer](https://packer.io/) is an open source tool for creating identical machine images for multiple platforms from a single source configuration

### Packer Template

3 main parts
- variables
  - contain the list of variables you need to use or need across other sections on the Packer Template JSON file
- builders
  - define what image we are going to create and for which technology/platform we are going to create an image for like AWS, DOCKER, VirtualBox, OpenStack etc.
- provisioners
  - the list of built-in or external configuration on management tools like Shell, Ansible, Chef, PowerShell
  - adding a necessary software/programs to it
  
*reference [Template Structure](https://packer.io/docs/templates/index.html)*

```
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": ""
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "us-east-1",
    "source_ami_filter": {
      "filters": {
        "virtualization-type": "hvm",
        "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",
        "root-device-type": "ebs"
      },
      "owners": ["099720109477"],
      "most_recent": true
    },
    "instance_type": "t2.micro",
    "ssh_username": "ubuntu",
    "ami_name": "packer-example {{timestamp}}"
  }]
}
```

### Interesting Command
- validate
  - validate the template
  - output should be *Template validated successfully.*
- build
  - build your image
  - artifacts are the results of a build, and typically represent an ID (such as in the case of an AMI)

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
