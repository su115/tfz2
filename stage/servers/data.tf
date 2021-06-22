data "terraform_remote_state" "network"{
	backend = "s3"
	config={
		bucket="terra-state-15-49-35"
		key="stage/vpc/terraform.tfstate"
		region="eu-west-1"
	}
}

locals {
	vpc_id=data.terraform_remote_state.network.outputs.vpc_id
	sub1_id=data.terraform_remote_state.network.outputs.sub1
}
