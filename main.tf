terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "example" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
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

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  ami           = "ami-062f0cc54dbfd8ef1"
  instance_type = "t2.micro"
  key_name   = "<pem_file_name>"
  vpc_security_group_ids = [aws_security_group.example.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker git
              systemctl start docker
              systemctl enable docker
              git clone https://github.com/Utkarsh067/Dockerise-Web-App.git /home/ec2-user/app
              cd /home/ec2-user/app
              docker build -t virtual-library .
              docker run -d -p 80:80 virtual-library
              EOF

  tags = {
    Name = "Server"
  }
}
