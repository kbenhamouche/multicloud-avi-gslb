
# Create the VPC
resource "aws_vpc" "aws-demo-vpc" {
  cidr_block = var.aws_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_name}-${var.app_environment}-vpc"
    Environment = var.app_environment
  }
}

# Define the subnet
resource "aws_subnet" "aws-demo-subnet" {
  vpc_id = aws_vpc.aws-demo-vpc.id
  cidr_block = var.aws_subnet_cidr
  availability_zone = var.aws_az
  tags = {
    Name = "${var.app_name}-${var.app_environment}-subnet"
    Environment = var.app_environment
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "aws-gw" {
  vpc_id = aws_vpc.aws-demo-vpc.id
  tags = {
    Name = "${var.app_name}-${var.app_environment}-igw"
    Environment = var.app_environment
  }
}

# Define the route table to the internet
resource "aws_route_table" "aws-route-table" {
  vpc_id = aws_vpc.aws-demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-gw.id
  }
  tags = {
    Name = "${var.app_name}-${var.app_environment}-route-table"
    Environment = var.app_environment
  }
}

# Assign the public route table to the subnet
resource "aws_route_table_association" "aws-route-table-association"{
  subnet_id = aws_subnet.aws-demo-subnet.id
  route_table_id = aws_route_table.aws-route-table.id
}

# Define the security group for HTTP web server
resource "aws_security_group" "aws-web-sg" {
  name = "${var.app_name}-${var.app_environment}-web-sg"
  description = "Allow incoming HTTP connections"
  vpc_id = aws_vpc.aws-demo-vpc.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.app_name}-${var.app_environment}-web-sg"
    Environment = var.app_environment
  }
}

# Get latest Ubuntu 18.04 AMI
data "aws_ami" "ubuntu-18_04" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name" 
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# Create Elastic IP for web server
resource "aws_eip" "aws-web-eip" {
  vpc = true
  tags = {
    Name = "${var.app_name}-${var.app_environment}-elastic-ip"
    Environment = var.app_environment
  }
}

// key pair creation
resource "random_id" "aws_instance_id" {
  byte_length = 8
}

resource "tls_private_key" "aws_vm-key" {
  algorithm = "RSA"
}

module "key_pair_vm" {
  source = "terraform-aws-modules/key-pair/aws"
  public_key = tls_private_key.aws_vm-key.public_key_openssh
  key_name = "web"
}

# Create EC2 Instances for Web Server
resource "aws_instance" "aws-web-server" {
  ami = data.aws_ami.ubuntu-18_04.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.aws-demo-subnet.id
  vpc_security_group_ids = [aws_security_group.aws-web-sg.id]
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "web"
  user_data = file("aws-user-data.sh")
  tags = {
    Name = "${var.app_name}-${var.app_environment}-web-server"
    Environment = var.app_environment
  }
}

#Associate Elastic IP to Web Server
resource "aws_eip_association" "aws-web-eip-association" {
  instance_id = aws_instance.aws-web-server.id
  allocation_id = aws_eip.aws-web-eip.id
}
