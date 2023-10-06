#!/bin/bash

# potegowanie petla

if [[ $# == 2 ]]; then
  pot=$1
  for (( i=1; i<$2; i++)); do
	pot=$(( $pot*$1 ))
  done
  echo $pot
fi
