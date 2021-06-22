# Save to bucket terraform.tfstate
terraform{
	backend "s3"{
	bucket="terra-state-15-49-35"
	key="stage/vpc/terraform.tfstate"
	region="eu-west-1"
	dynamodb_table="lock"
	encrypt=true
	}
}

# PROVIDER
provider "aws"{
	profile="Igor"
	region="eu-west-1"
}


# VPC
resource "aws_vpc" "custom_vpc"{
	cidr_block = "10.0.0.0/16"
	tags={
		Name="Custom VPC tfz2"
	}
}



# PUBLIC SUBNET 1
resource "aws_subnet" "sub1"{
	vpc_id=aws_vpc.custom_vpc.id
	cidr_block="10.0.10.0/24"
	map_public_ip_on_launch=true
	tags = {
		Name="Custom Public Sub 1"
	}
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "gt"{
	vpc_id=aws_vpc.custom_vpc.id
	tags={
		Name="Internet Gateway"
	}
}

# ROUTE TABLE
resource "aws_route_table" "art"{
	vpc_id=aws_vpc.custom_vpc.id
	route{
		cidr_block="0.0.0.0/0"
		gateway_id=aws_internet_gateway.gt.id
	}
}

# ROUTE TABLE ASSOCIATION to sub1
resource "aws_route_table_association" "rta1"{
	subnet_id=aws_subnet.sub1.id
	route_table_id=aws_route_table.art.id
}




















