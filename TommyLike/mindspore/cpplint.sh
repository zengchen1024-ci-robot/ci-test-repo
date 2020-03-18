#!/bin/sh

entry_dir=$(pwd)
my_dir=$(dirname $0)

cd $my_dir/../../common
source $(pwd)/utils.sh

cd $my_dir

workspace=/home/workspace
test -d $workspace || mkdir -p $workspace

# Clone mindspore_deploy
err=$(clone_mindspore_deploy $workspace)
if [ $? -ne 0 ]; then
  echo $err
  exit 1
fi
deploy_path=$workspace/mindspore_deploy

# Source env
export PATH=/usr/local/python/python375/bin:$PATH

# Source common-env
source ${deploy_path}/common/scripts/common/common-lib.sh
if [ $? -ne 0 ];then
    echo "[ERROR] Source common-lib is failed."
    exit 1
fi

project_path=$GOPATH/src/github.com/TommyLike/mindspore

# Exclude folder
exclude_folder="tests,third_party,graphengine"
echo "Exclude folder(${exclude_folder})."

for folder in ${exclude_folder//,/ }; do
    rm -rf ${project_path}/${folder}
done

# Run cppcheck
echo "Run cppcheck."
output=${workspace}/cppcheck-style.xml
cppcheck --enable=style --xml --inline-suppr --force --xml-version=2 ${project_path} 2> $output

error_number=$(grep "<error id=" ${output} | wc -l)
if [ $error_number -ne 0 ]; then
  echo "Run cppcheck failed"
  exit 1
fi
