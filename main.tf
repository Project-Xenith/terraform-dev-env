resource "aws_vpc" "terraform-dev-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "dev-env"
  }
}

resource "aws_subnet" "public-subnet-dev-env" {
  vpc_id                  = aws_vpc.terraform-dev-env.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "terraform-dev-evn-public-subnet"
  }
}

resource "aws_internet_gateway" "terraform-dev-env-ig" {
  vpc_id = aws_vpc.terraform-dev-env.id

  tags = {
    name = "terraform-dev-env-internet-gateway"
  }
}

resource "aws_route_table" "public_route_table_dev_env" {
  vpc_id = aws_vpc.terraform-dev-env.id

  tags = {
    Name = "terrraform_dev_env_route_table"
  }
}

resource "aws_route" "global_route" {
  route_table_id         = aws_route_table.public_route_table_dev_env.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform-dev-env-ig.id
}

# steps for creating a route table for a subnet :
# step 1. Create a Subnet 
# (the subnet is automatically connected to a default route table, it is default behaviour of terraform)
# Step 2. Create a route table
# Step 3. Create a route for the route table you have created
# Step 4. Associate the subnet with the newly created route table

resource "aws_route_table_association" "public_subnet_public_route_table_association" {
  subnet_id      = aws_subnet.public-subnet-dev-env.id
  route_table_id = aws_route_table.public_route_table_dev_env.id
}

resource "aws_security_group" "Public_security_group" {
  name        = "Public_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.terraform-dev-env.id

  ingress {
    description      = "Allows global traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_global_traffic"
  }
}

resource "aws_key_pair" "terraform_dev_srever_key_pair" {
  key_name   = "dev_env_server_key"
  public_key = file("~/.ssh/terraform_dev_env_key.pub")
}

resource "aws_instance" "terraform_dev_env_public_server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.public_server_ami.id

  key_name               = aws_key_pair.terraform_dev_srever_key_pair.id
  vpc_security_group_ids = [aws_security_group.Public_security_group.id]
  subnet_id              = aws_subnet.public-subnet-dev-env.id

  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "Dev_env_public_server"
  }

  user_data = file("userdata.tpl")
}