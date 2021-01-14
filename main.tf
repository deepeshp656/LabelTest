terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.23.0"
    }
  }


  backend "remote" {
    organization = "Deepesh-Test"

    workspaces {
      name = "LabelTest"
    }
  }
 }

provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
 

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
