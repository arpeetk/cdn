variable "github_oidc_provider_name" {
  type = string
  description = "Name of OIDC provider"
}
variable "github_oidc_provider_url" {
  type = string
  description = "URL for OIDC provider"
  default = "https://token.actions.githubusercontent.com"
}

variable "github_oidc_client_id_list" {
  type = list(string)
  description = "List of client id's"
  default = [ "sts.amazonaws.com" ]
}

variable "github_oidc_thumbprint_list" {
  type = list(string)
  description = "List of OIDC thumbprints"
  default = [ "a031c46782e6e6c662c2c87c76da9aa62ccabd8e" ]
}

variable "github_org" {
  type = string
  description = "Name of Github Org"
  default = "arpeetk"
}

variable "tags" {}