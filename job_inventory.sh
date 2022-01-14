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
#    See the License for the spefic language governing permissions and
#    limitations under the License.
#
#    Python versions installer via pyenv.
#
python_versions_arr=("3.6" "3.7" "3.8" "3.9" "3.10")
SPARK_LOCAL_IP=127.0.0.1
SETUPTOOLS_USE_DISTUTILS=stdlib

check_folders(){
  ls /home/jenkins/tools
  ls /home/jenkins/tools/*
}

check_python_versions(){
  python --version || echo "python not found"
  python3 --version || echo "python3 not found"
  for version in "${python_versions_arr[@]}"; do
    python${version} --version || echo "\"python${version} not found\""
  done
}

check_jenkins_tools(){
  /home/jenkins/tools/maven/latest/mvn -v || echo "mvn not found"
  /home/jenkins/tools/gradle4.3/gradle -v || echo "gradle not found"
}

check_installed_CLI(){
  gcloud -v || echo "gcloud not found"
  kubectl version || echo "kubectl not found"
}

check_maven(){
  echo "Maven home ${MAVEN_HOME:-}"
  env
}

check_env(){
  BUILD_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/1576/
  tmp_unaccessed_for=48
  XDG_SESSION_ID=255
  ROOT_BUILD_CAUSE_TIMERTRIGGER=true
  HUDSON_SERVER_COOKIE=14925adb602d4986
  SHELL=/bin/bash
  SSH_CLIENT=3.94.149.17 49444 22
  BUILD_TAG=jenkins-beam_Inventory_apache-beam-jenkins-1-1576
  GIT_PREVIOUS_COMMIT=872455570ae7f3e2e35360bccf93b503ae9fdb5c
  ROOT_BUILD_CAUSE=TIMERTRIGGER
  WORKSPACE=/home/jenkins/jenkins-slave/workspace/beam_Inventory_apache-beam-jenkins-1
  JOB_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/
  RUN_CHANGES_DISPLAY_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/1576/display/redirect?page=changes
  USER=jenkins
  RUN_ARTIFACTS_DISPLAY_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/1576/display/redirect?page=artifacts
  CODECOV_TOKEN=****
  GIT_CHECKOUT_DIR=src
  GIT_COMMIT=a3bf36eae08a7e31ec862674180466166b9cf501
  JENKINS_HOME=/home/jenkins/jenkins-home
  MAIL=/var/mail/jenkins
  PATH=/home/jenkins/tools/java/latest1.8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
  RUN_DISPLAY_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/1576/display/redirect
  _=/usr/bin/env
  PWD=/home/jenkins/jenkins-slave/workspace/beam_Inventory_apache-beam-jenkins-1
  COVERALLS_REPO_TOKEN=****
  JAVA_HOME=/home/jenkins/tools/java/latest1.8
  HUDSON_URL=https://ci-beam.apache.org/
  LANG=en_US.UTF-8
  JOB_NAME=beam_Inventory_apache-beam-jenkins-1
  BUILD_DISPLAY_NAME=#1576
  sha1=master
  BUILD_CAUSE=TIMERTRIGGER
  BUILD_ID=1576
  JENKINS_URL=https://ci-beam.apache.org/
  JOB_BASE_NAME=beam_Inventory_apache-beam-jenkins-1
  GIT_PREVIOUS_SUCCESSFUL_COMMIT=872455570ae7f3e2e35360bccf93b503ae9fdb5c
  RUN_TESTS_DISPLAY_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/1576/display/redirect?page=tests
  HOME=/home/jenkins
  SPARK_LOCAL_IP=127.0.0.1
  SHLVL=2
  GIT_BRANCH=origin/master
  CI=true
  EXECUTOR_NUMBER=2
  WORKSPACE_TMP=/home/jenkins/jenkins-slave/workspace/beam_Inventory_apache-beam-jenkins-1@tmp
  JENKINS_SERVER_COOKIE=14925adb602d4986
  GIT_URL=https://github.com/apache/beam.git
  NODE_LABELS=apache-beam-jenkins-1 beam
  LOGNAME=jenkins
  SSH_CONNECTION=3.94.149.17 49444 10.128.0.128 22
  HUDSON_HOME=/home/jenkins/jenkins-home
  SETUPTOOLS_USE_DISTUTILS=stdlib
  NODE_NAME=apache-beam-jenkins-1
  BUILD_CAUSE_TIMERTRIGGER=true
  BUILD_NUMBER=1576
  JOB_DISPLAY_URL=https://ci-beam.apache.org/job/beam_Inventory_apache-beam-jenkins-1/display/redirect
  TEST_HOST=apache-beam-jenkins-1
  XDG_RUNTIME_DIR=/run/user/1017
  HUDSON_COOKIE=3b098e87-9e7a-413d-ba7e-7900701408c6
}

check_python_venv(){
  for version in "${python_versions_arr[@]}"; do
    versionSuffix=$(echo "$version" | sed -e 's/\.//g')
    python${version} -m venv test${versionSuffix} && . ./test${versionSuffix}/bin/activate && python --version && deactivate || echo "\"python ${version} not found\""
  done
}

check_docker(){
  docker system prune --all --filter until=24h --force
  docker volume prune --force
}

check_temp_files(){
  echo "Current size of /tmp dir is $(sudo du -sh /tmp)"
  echo "Deleting files accessed later than \${tmp_unaccessed_for} hours ago"
  sudo find /tmp -type f -amin +$((60*${tmp_unaccessed_for})) -print -delete
  echo "Size of /tmp dir after cleanup is \$(sudo du -sh /tmp)"
}

run_job_inventory(){
  check_folders
  check_python_versions
  check_jenkins_tools
  check_installed_CLI
  check_maven
  check_python_venv
  check_docker
  check_temp_files
}

run_job_inventory
