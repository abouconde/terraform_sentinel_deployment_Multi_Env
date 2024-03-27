
variable "prefix" {
  description = "Prefix for the resource names"
  type        = string
}

variable "environments" {
  description = "A map of environments to their locations"
  type        = map(string)
  default = {
    "dev" = "France Central"
    "staging" = "North Europe"
    "prod" = "West Europe"
  }
}

variable "environment" {
  description = "The environment to deploy to"
}
