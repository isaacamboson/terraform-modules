#this variable ensures that the following tags must be provided when deploying resources
variable "required_tags" {
  description = "Tags required to be specified on all resources"
  type = object(
    {
      Environment = string
      OwnerEmail  = string
      System      = string
      Backup      = string
      Region      = string
    }
  )

  validation {
    condition     = var.required_tags.OwnerEmail != "" && var.required_tags.OwnerEmail == lower(var.required_tags.OwnerEmail)
    error_message = "OwnerEmail must be lowercase and non-empty."
  }

  validation {
    condition     = contains(["dev", "test", "prod", "uat"], var.required_tags.Environment)
    error_message = "Environment must be in the following list: ['dev', 'test', 'prod', 'uat']"
  }

  validation {
    condition     = contains(["yes", "no", "YES", "NO", "Yes", "No"], var.required_tags.Backup)
    error_message = "Backup must be one of the following options: ['YES', 'NO', 'Yes', 'No', 'yes', 'no']"
  }

  validation {
    condition     = var.required_tags.Region != "" && var.required_tags.Region == lower(var.required_tags.Region)
    error_message = "Region must be lowercase and non-empty."
  }

  validation {
    condition     = var.required_tags.System == "Retail Reporting"
    error_message = "System must be 'Retail Reporting'"
  }

}