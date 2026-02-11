variable "name" {}
variable "subnet_id" {}
variable "security_groups" { type = list(string) }
variable "key_name" {}
variable "associate_public_ip" { type = bool }
