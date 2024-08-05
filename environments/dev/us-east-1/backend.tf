terraform {
  backend "s3" {
    bucket         = "stackbuckstateisaac-aut"
    key            = "stack_modules_env_us-east-1.tfstate"
    region         = "us-east-1"
    dynamodb_table = "statelock-tf"
  }
}