// To Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {
  description = "Name of the SSH key pair"
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}.pem"
}

# Create a security group
resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  vpc_id = aws_vpc.my_vpc.id
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "moharik_server" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
   subnet_id             = aws_subnet.public_subnet.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  user_data              = file("script.sh")
  
  tags = {
    Name = "public_instance"
  }
}