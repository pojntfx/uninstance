resource "aws_key_pair" "uninstance" {
  key_name   = "uninstance-ssh-public-key"
  public_key = file(var.ssh_public_key)
}

resource "aws_vpc" "uninstance" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_internet_gateway" "uninstance" {
  vpc_id = aws_vpc.uninstance.id
}

resource "aws_subnet" "uninstance" {
  vpc_id                  = aws_vpc.uninstance.id
  cidr_block              = "10.0.1.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.uninstance.ipv6_cidr_block, 8, 1)
  map_public_ip_on_launch = true
}

resource "aws_route_table" "uninstance" {
  vpc_id = aws_vpc.uninstance.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.uninstance.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.uninstance.id
  }
}

resource "aws_route_table_association" "uninstance" {
  subnet_id      = aws_subnet.uninstance.id
  route_table_id = aws_route_table.uninstance.id
}

resource "aws_security_group" "uninstance" {
  vpc_id = aws_vpc.uninstance.id

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
    Name = "uninstance-firewall"
  }
}

data "aws_ami" "alma" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["AlmaLinux OS 9*x86_64*"]
  }
}

resource "aws_instance" "alma_aws_pvm_node_1" {
  ami                         = data.aws_ami.alma.id
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.uninstance.id
  associate_public_ip_address = true
  ipv6_address_count          = 1

  user_data              = file("cloud-init-alma-aws.yaml")
  key_name               = aws_key_pair.uninstance.key_name
  vpc_security_group_ids = [aws_security_group.uninstance.id]

  tags = {
    Name = "alma-aws-pvm-node-1"
  }
}
