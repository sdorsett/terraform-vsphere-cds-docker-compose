provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_virtual_machine_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "cloned_virtual_machine" {
  name             = var.vsphere_virtual_machine_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vsphere_virtual_machine_num_cpus 
  memory   = var.vsphere_virtual_machine_memory 
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.template.disks.0.size
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone = true

    customize {
      linux_options {
        host_name = var.vsphere_virtual_machine_host_name 
        domain    = var.vsphere_virtual_machine_domain
      }
      network_interface {
        ipv4_address = var.vsphere_virtual_machine_ip_address
        ipv4_netmask = var.vsphere_virtual_machine_netmask
      }
      ipv4_gateway = var.vsphere_virtual_machine_gateway

      dns_server_list = ["${var.vsphere_virtual_machine_dns_server}"]
      dns_suffix_list = ["${var.vsphere_virtual_machine_domain}"]

    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y python3",
    ]
    connection {
      type          = var.virtual_machine_cds_connection_type
      host          = var.vsphere_virtual_machine_ip_address
      user          = var.virtual_machine_cds_connection_user
      private_key   = file(var.virtual_machine_cds_private_key)

    }
  }

}
