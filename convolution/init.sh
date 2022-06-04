#!/bin/bash

## Args
ARG0=$0
ARG1=$1
ARG2=$2

## ansi color
REDBOLD="\033[1;31m"
GREENBOLD="\033[1;32m"
PURPLEBOLD="\033[1;34m"
WHITEBOLD="\033[1;37m"
RESET="\033[0m"

## functions
function helpmsg() {
  local SCRIPT_NAME=$(basename $ARG0)
  printf "$GREENBOLD./$SCRIPT_NAME\t\t-- Help Message$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME docker\t-- Run Docker$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME docker gpu\t-- Run Docker with GPU Support$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME build\t\t-- Build Native Code Bind To Python$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME run\t\t-- Run Test Code$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME clean\t\t-- Clean Build Output$RESET\n"
  printf "$GREENBOLD./$SCRIPT_NAME nvprof\t-- Profile With Nvprof$RESET\n"
  exit
}

function main() {
  if [[ "$ARG1" == "docker" ]]; then
    local IMAGE_NAME="pytorch/pytorch-customized"
    if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
      echo "Building customized pytorch image ..."
      docker build --tag $IMAGE_NAME -f Dockerfile .
    fi
    if [[ "$ARG2" == "gpu" ]]; then
      docker run --gpus all --privileged \
                 --rm -it -v $PWD:/root/workspace $IMAGE_NAME
    else
      docker run --rm -it -v $PWD:/root/workspace $IMAGE_NAME
    fi
  elif [[ "$ARG1" == "build" ]]; then
    python setup.py install
  elif [[ "$ARG1" == "run" ]]; then
    python run_test.py
  elif [[ "$ARG1" == "profile" ]]; then
    nvprof  --metrics dram_utilization,warp_execution_efficiency,sm_efficiency,achieved_occupancy python run_test.py
  elif [[ "$ARG1" == "clean" ]]; then
    python setup.py clean
    rm -rf build dist *.egg*
  else
    helpmsg
  fi
}

## execute
main
