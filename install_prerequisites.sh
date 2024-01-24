#!/usr/bin/env bash

# VARIABLES
VERSION="0.0.1"

# USE BASH STRICT MODE - http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# if [ -e ./.venv/bin/activate ]; then source ./.venv/bin/activate; else python3 -m venv .venv && source ./.venv/bin/activate; fi

install_prerequisites () {
  if command -v pipx >/dev/null 2>&1
  then
    echo -e "pipx already present. \t Installation skipped..."
  else
    # Documentation: https://pipx.pypa.io/stable/
    # Source code: https://github.com/pypa/pipx
    echo "Installing the latest pipx version for MacOS via brew..." && \
    brew install pipx
    pipx ensurepath
  fi

  if command -v ansible >/dev/null 2>&1
  then
    echo -e "ansible already present. \t Installation skipped..."
  else
    # Documentation: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
    echo "Installing the latest ansible version for MacOS via pipx..." && \
    pipx install --include-deps ansible # Full
    # Doc: https://blog.stephane-robert.info/docs/infra-as-code/gestion-de-configuration/ansible/ansible-lint/
    pipx install "ansible-lint[yamllint]"
    # pipx install ansible-core # Minimal
    # pipx install ansible-core==2.12.3 # Selected version
  fi

  if command -v molecule >/dev/null 2>&1
  then
    echo -e "molecule already present. \t Installation skipped..."
  else
    # Documentation: https://blog.stephane-robert.info/post/ansible-molecule/
    echo "Installing the latest molecule version for MacOS via pipx..." && \
    # Old install : python3 -m pip install molecule molecule-plugins ansible-core ansible-lint --user
    pipx install molecule molecule-plugins ansible-core ansible-lint
    # molecule init role --driver-name docker --verifier-name ansible dadideo.monrole
  fi
}



color() {
  printf '\033[%sm%s\033[m\n' "$@"
  # usage color "31;5" "string"
  # 0 default
  # 5 blink, 1 strong, 4 underlined
  # fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
  # bg: 40 black, 41 red, 44 blue, 45 purple
}

echo "Welcome to EvilCorp (X/@dadideo)"
echo "(pre-requisites: brew/pipx/ansible)"
echo "Please note, it's a pre-alpha version (v${VERSION}) of the DevOps tooling."
echo "Tested only on MacOS Ventura 13.6.3 (M1 2020)"
echo ""
LINE0="== NOT USE IN PRODUCTION ! NOT USE IN PRODUCTION ! NOT USE IN PRODUCTION =="
LINE1="==  (Because: refactoring/review required) =="
color '31;1' "$LINE0"
color '31;5' "$LINE1"
color '31;1' "$LINE0"
echo ""
echo "Do you wish to install all pre-requisites for this project?"
echo ""
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_prerequisites; exit;;
    No ) color '32;4' "Exiting..."; exit;;
    * ) echo "Invalid response";
  esac
done
