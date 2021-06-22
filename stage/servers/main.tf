terraform{
	backend "s3"{
	bucket="terra-state-15-49-35"
	key="stage/servers/terraform.tfstate"
	region="eu-west-1"
	dynamodb_table="lock"
	encrypt=true
	}
}

# Provider
provider "aws"{
	profile="Igor"
	region="eu-west-1"
}


# INSTANCE
resource "aws_instance" "server"{
  ami           = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.all_allow.id]
  count = 2
  associate_public_ip_address = true
  key_name = "ansible"
  subnet_id=local.sub1_id
  tags = {
    Name = "Ubuntu-${count.index}"
  }
}

resource "aws_security_group" "all_allow" {
  name = "all_allow"
  vpc_id=local.vpc_id
  ingress{
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}































