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
  type = list(string)
  default = [
    "arts",
    "blog",
    "copinchapedia",
    "docs",
    "fossil",
    "git",
    "m00",
    "pph",
    "repos",
    "wiki"
  ]
}

resource "porkbun_dns_record" "cnames" {
  count = length(var.names)
  name    = var.names[count.index]
  domain  = "copincha.org"
  content = "copincha.org."
  type    = "CNAME"
}