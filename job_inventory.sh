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
set -euo pipefail
python_versions_arr=("3.8" "3.6" "3.7" "3.9" "3.10")
SPARK_LOCAL_IP=127.0.0.1
SETUPTOOLS_USE_DISTUTILS=stdlib

ls /home/jenkins/tools
ls /home/jenkins/tools/*
python --version || echo "python not found"
python3 --version || echo "python3 not found"
for version in "${python_versions_arr[@]}"; do
  python${version} --version || echo "\"python${version} not found\""
done
/home/jenkins/tools/maven/latest/mvn -v || echo "mvn not found"
/home/jenkins/tools/gradle4.3/gradle -v || echo "gradle not found"
gcloud -v || echo "gcloud not found"
kubectl version || echo "kubectl not found"
for version in "${python_versions_arr[@]}"; do
    versionSuffix = $( echo "$version" | sed -e 's/\.//g' )
  python${version} -m venv test${versionSuffix} && . ./test${versionSuffix}/bin/activate && python --version && deactivate || echo \"python ${version} not found\"
done
echo "Maven home $MAVEN_HOME"
env
docker system prune --all --filter until=24h --force
docker volume prune --force
echo "Current size of /tmp dir is $(sudo du -sh /tmp)"
echo "Deleting files accessed later than \${tmp_unaccessed_for} hours ago"
sudo find /tmp -type f -amin +$((60*${tmp_unaccessed_for})) -print -delete
echo "Size of /tmp dir after cleanup is \$(sudo du -sh /tmp)"
