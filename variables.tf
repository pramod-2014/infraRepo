variable "resource_group_name" {
  type    = string
  default = "aks_rg"
}
variable "location" {
  type    = string
  default = "central India"
}

variable "vnet_name" {
  type    = string
  default = "aks_vnet"

}

variable "subnet_name" {
  type    = string
  default = "aks_subnet"
}
variable "virtua_interface" {
  type    = string
  default = "aks_nic"

}