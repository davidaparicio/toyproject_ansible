#!/usr/bin/env bash

set -euo pipefail

# ansible-lint --fix playbook.yaml # Format the playbook file --write all
ansible-lint playbook.yml
# ansible-lint -t idempotency playbook.yml # Include (only)
# ansible-lint -x formatting,metadata playbook.yml # Exclude
ansible-playbook -i inventory playbook.yml --check
echo ""
echo "Launch the Ansible playbook?"
echo ""
select yn in "Yes" "No"; do
  case $yn in
    Yes ) ansible-playbook -i inventory playbook.yml; exit;;
    No ) color '32;4' "Exiting..."; exit;;
    * ) echo "Invalid response";
  esac
# https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_checkmode.html
# https://docs.ansible.com/ansible/2.8/user_guide/playbooks_checkmode.html
