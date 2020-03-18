#!/bin/sh

clone_mindspore_deploy() {
  out_dir=$1
  git clone https://github.com/mindspore-ai/mindspore_deploy.git ${out_dir}/mindspore_deploy
  if [ $? -ne 0 ]; then
    echo "[ERROR] Clone mindspore_deploy failed"
    return 1
  fi
}
