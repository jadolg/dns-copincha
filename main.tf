terraform {
  required_providers {
    porkbun = {
      source = "cullenmcdermott/porkbun"
      version = "0.3.0"
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
    "m00"="m00",
    "pph"="pph",
    "repos"="repos",
    "wiki"="wiki",
    "3d-a-lo-cubano"="3d-a-lo-cubano"
  }
}

variable "names_hh" {
  type = map(string)
  default = {
    "git"="git",
  }
}

resource "porkbun_dns_record" "cnames" {
  for_each = var.names
  name    = each.value
  domain  = "copincha.org"
  content = "copincha.org."
  type    = "CNAME"
}

resource "porkbun_dns_record" "cnames_hh" {
  for_each = var.names_hh
  name    = each.value
  domain  = "copincha.org"
  content = "hh.akiel.dev."
  type    = "CNAME"
}
