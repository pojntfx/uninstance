resource "aws_vpc" "this" {
  provider = aws.primary

  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_internet_gateway" "this" {
  provider = aws.primary

  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "this" {
  provider = aws.primary

  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, 1)
  map_public_ip_on_launch = true
}

resource "aws_route_table" "this" {
  provider = aws.primary

  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "this" {
  provider = aws.primary

  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_security_group" "this" {
  provider = aws.primary

  vpc_id = aws_vpc.this.id

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "udp"
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
    Name = "${var.name}-firewall"
  }
}

data "aws_ami" "alma" {
  provider = aws.primary

  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

resource "aws_instance" "this" {
  provider = aws.primary

  ami                         = data.aws_ami.alma.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.this.id
  private_ip                  = "10.0.1.42"
  associate_public_ip_address = true
  ipv6_address_count          = 1

  root_block_device {
    volume_size = 50
  }

  user_data              = var.user_data
  key_name               = var.public_key_name
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = var.name
  }
}

