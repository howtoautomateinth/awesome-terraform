# filter with regions and services
data "aws_ip_ranges" "european_ec2" {
  regions  = ["eu-west-1", "eu-central-1"]
  services = ["ec2"]
}

# use in cidr_blocks based on attribute references https://www.terraform.io/docs/providers/aws/d/ip_ranges.html
resource "aws_security_group" "from_europe" {
  name = "from_europe"

  ingress {
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks      = data.aws_ip_ranges.european_ec2.cidr_blocks
    ipv6_cidr_blocks = data.aws_ip_ranges.european_ec2.ipv6_cidr_blocks
  }

  tags = {
    CreateDate = data.aws_ip_ranges.european_ec2.create_date
    SyncToken  = data.aws_ip_ranges.european_ec2.sync_token
  }
}