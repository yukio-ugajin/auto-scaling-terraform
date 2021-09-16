terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3"
		}
	}

  backend "s3" {
    bucket = "ugajinterraformstate"
    key    = "terraform-states/auto-scaling-terraform"
    region = "us-west-2"
  }
}
