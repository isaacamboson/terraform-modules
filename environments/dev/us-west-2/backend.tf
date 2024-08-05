terraform {
  backend "s3" {
    bucket         = "stackbuckstateisaac"
    key            = "stack_modules_env_us-west-2.tfstate"
    region         = "us-east-1"
    dynamodb_table = "statelock-tf"
  }
}