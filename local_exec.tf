resource "null_resource" "run-ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory.yml ansible/site.yml"
  }
  depends_on = [vsphere_virtual_machine.cloned_virtual_machine]
}
