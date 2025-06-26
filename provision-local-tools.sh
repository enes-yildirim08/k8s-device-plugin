#!/bin/bash -e
export ANSIBLE_ROLES_PATH=/vagrant/ansible/roles
export ANSIBLE_CONFIG=/vagrans/ansible/ansible.cfg

ansible-playbook \
  ./playbooks/provision-local-tools.yml
