terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}

// to import
data "aws_instances" "ec2" {
  filter {
    name = "tag:Name"
    values = [var.aws_instance_name]
  }
  instance_state_names = ["running", "pending", "stopped"]
}

import {
  to = aws_instance.kbsec_ec2
  id  = data.aws_instances.ec2.ids[0]
}

resource "aws_instance" "kbsec_ec2" {
}

variable "aws_instance_name" {
  type = string
  default = "tfe-fdo-test"
}
