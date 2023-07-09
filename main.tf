terraform {
  required_providers {
    porkbun = {
      source = "cullenmcdermott/porkbun"
    }
  }
}

variable "porkbun_api_key" {
  type = string
  sensitive = true
}

variable "porkbun_secret_key" {
  type = string
  sensitive = true
}

provider "porkbun" {
  api_key = var.porkbun_api_key
  secret_key = var.porkbun_secret_key
}

resource "porkbun_dns_record" "main_record" {
  name    = ""
  domain  = "copincha.org"
  content = "37.218.242.73"
  type    = "A"
}

variable "names" {
  type = map(string)
  default = {
    "arts"="arts",
    "blog"="blog",
    "copinchapedia"="copinchapedia",
    "docs"="docs",
    "fossil"="fossil",
    "git"="git",
    "m00"="m00",
    "pph"="pph",
    "repos"="repos",
    "wiki"="wiki"
  }
}

resource "porkbun_dns_record" "cnames" {
  for_each = var.names
  name    = each.value
  domain  = "copincha.org"
  content = "copincha.org."
  type    = "CNAME"
}
