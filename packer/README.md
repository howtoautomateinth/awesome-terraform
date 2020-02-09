# Packer Example

> Build Automated Machine Images

## Steps

- packer validate packer-example.json
- create terraform.tfvars that contains your AWS credentail
    - AWS_ACCESS_KEY
    - AWS_SECRET_KEY
    - AWS_REGION
- packer build packer-example.json

## Note

define aws credentail outside and references by [user variables](/https://packer.io/docs/templates/user-variables.html)