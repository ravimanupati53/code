## ssh-key

This repo helps us to copy the ssh-key to any number of nodes at a time by using the Ansible Playbook.

The vars file in environment_vars directory contains the `user id` and the `ssh-keygen file` that passes as the parameter to the main `ssh_key.yml` file

The host directory contains the list of destination IP addresses/hostnames where the `SSH-KEY` need to copy.

***ssh_key.yml*** file executes the playbook in copying the key to other nodes.

