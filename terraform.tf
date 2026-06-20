terraform {
    required_providers{
        aws ={
            source  = "hashicorp/aws"
      version = "~> 6.0"
        }

    }

backend "s3" {
    bucket = "terra-automate-state-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terra_automate_state_table"
}

}