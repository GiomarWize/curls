#!/usr/bin/env bash
#
#    Licensed to the Apache Software Foundation (ASF) under one or more
#    contributor license agreements.  See the NOTICE file distributed with
#    this work for additional information regarding copyright ownership.
#    The ASF licenses this file to You under the Apache License, Version 2.0
#    (the "License"); you may not use this file except in compliance with
#    the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
#    Python version 3.6.13-3.7.10-3.8.9-3.9.4 installer via pyenv.
#
set -euo pipefail

pyenv_dependencies="make build-essential libssl-dev zlib1g-dev bzip2 \
libreadline-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
liblzma-dev"
python_versions_arr=("3.6.13" "3.7.10" "3.8.9" "3.9.4")

pyenv_dep(){
 sudo apt-get install -y "$1"
}

pyenv_install(){
  if [[ -d "$HOME"/.pyenv/ ]]; then
    sudo rm -r "$HOME"/.pyenv
  fi
  if [[ -e "$HOME"/pyenv_installer.sh ]]; then
    sudo rm "$HOME"/pyenv_installer.sh
  fi
  curl https://pyenv.run > "$HOME"/pyenv_installer.sh
  chmod +x "$HOME"/pyenv_installer.sh
  "$HOME"/pyenv_installer.sh
}

pyenv_post_install(){
cat <<EOT >> greetings.txt

# pyenv Config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi
EOT
}

pyenv_versions_install(){
  arr=("$@")
  for version in "${arr[@]}"; do
    "$HOME"/.pyenv/bin/pyenv install "$version"
  done
}

python_versions_setglobally(){
  arr=("$@")
  versions=""
  for ver in "${arr[@]}"; do
    if "$HOME"/.pyenv/bin/pyenv versions | grep -q"${ver}"; then
      versions+="${ver} "
    fi
  done
  "$HOME"/.pyenv/bin/pyenv global "${versions[@]}"
}

pyenv(){
 pyenv_dep "${pyenv_dependencies}"
 pyenv_install
 pyenv_post_install
 pyenv_versions_install "${python_versions_arr[@]}"
 python_versions_setglobally "${python_versions_arr[@]}"
}

pyenv
