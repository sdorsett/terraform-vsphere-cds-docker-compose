# vsphere login account. defaults to admin account
variable "vsphere_user" {
  default = "administrator@vsphere.local"
}

# vsphere account password. empty by default.
variable "vsphere_password" {}

# vsphere server, defaults to localhost
variable "vsphere_server" {
  default = "localhost"
}

# vsphere datacenter the virtual machine will be deployed to. empty by default.
variable "vsphere_datacenter" {}

# vsphere resource pool the virtual machine will be deployed to. empty by default.
variable "vsphere_resource_pool" {}

# vsphere datastore the virtual machine will be deployed to. empty by default.
variable "vsphere_datastore" {}

# vsphere network the virtual machine will be connected to. empty by default.
variable "vsphere_network" {}

# vsphere virtual machine template that the virtual machine will be cloned from. empty by default.
variable "vsphere_virtual_machine_template" {}

# the name of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_name" {}

# the number of vcpus to give the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_num_cpus" {}

# the amount of memory to give the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_memory" {}

# the hostname used by guest customization of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_host_name" {}

# the domain name to use with the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_domain" {}

# the dns server to use with the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_dns_server" {}

# the ip address to assign to the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_ip_address" {}

# the netmask to assign to the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_netmask" {}

# the default gateway to use with the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_gateway" {}

# the connection type used to issue commands to the deployed virtual machine
variable "virtual_machine_cds_connection_type" {
    default = "ssh"
}

# the user name used to connect to the deployed virtual machine
variable "virtual_machine_cds_connection_user" {
    default = "ubuntu"
}

# the ssh private key used to connect to the deployed virtual machine
variable "virtual_machine_cds_private_key" {
    default = "/home/ubuntu/.ssh/id_rsa"
}
