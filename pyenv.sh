#!/bin/bash
set -e
# Updated Script
# Vars
pyenv_dependencies="make build-essential libssl-dev zlib1g-dev bzip2 libreadline-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev"
python_versions_arr=("3.6.13" "3.7.10" "3.8.9" "3.9.4")

# Install pyenv dependencies
pyenv_dep(){
 sudo apt-get install -y "${pyenv_dependencies}"
}
pyenv_install(){
  if [[ -d $HOME/.pyenv/ ]]; then
    sudo rm -r $HOME/.pyenv
  fi
  if [[ -e $HOME/pyenv_installer.sh ]]; then
    sudo rm $HOME/pyenv_installer.sh
  fi
  curl https://pyenv.run > $HOME/pyenv_installer.sh
  chmod +x $HOME/pyenv_installer.sh
  $HOME/pyenv_installer.sh
}
pyenv_post(){
 echo '' >> $HOME/.bashrc
 echo '# pyenv Config' >> $HOME/.bashrc
 echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
 echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
 echo 'if which pyenv > /dev/null;then eval "$(pyenv init -)"; eval "$(pyenv init --path)"; eval "$(pyenv virtualenv-init -)"; fi' >> $HOME/.bashrc
}
# Install python versions
pyenv_versions_install(){
 arr=("$@")
for version in "${arr[@]}"; do
  $HOME/.pyenv/bin/pyenv install $version
done
}
# Setting globally
python_versions_setglobally(){
 arr=("$@")
 versions=""
for ver in "${arr[@]}"; do
  if [[ -n $($HOME/.pyenv/bin/pyenv versions | grep "${ver}") ]]; then
    versions+="${ver} "
  fi
done
 echo "${versions}"
 $HOME/.pyenv/bin/pyenv global "${versions[@]}"
}
pyenv(){
 pyenv_dep "${pyenv_dependencies}"
 pyenv_install
 pyenv_versions_install "${python_versions_arr[@]}"
 python_versions_setglobally "${python_versions_arr[@]}"
 pyenv_post
}
pyenv
