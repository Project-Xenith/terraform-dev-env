# this file handles data sources type of resources present within aws
# ubuntu 22.04 LTS 
# ami id    : ami-053b0d53c279acc90
# owner id  : 099720109477

data "aws_ami" "public_server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}