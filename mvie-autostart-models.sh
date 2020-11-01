#!/usr/bin/env bash

DEPLOY="/opt/ibm/vision-edge/bin/deploy_zip_model.sh"

MODELS="/opt/ibm/mvie-autostart-models/*.zip"

# check all the filenames before starting
for fn in $MODELS
do
  if [ ! -f $fn ]; then
    continue
  fi
  F=$(basename $fn .zip) 
  M=$(echo $F | cut -f1 -d.) # Model
  P=$(echo $F | cut -f2 -d.) # Port
  G=$(echo $F | cut -f3 -d.) # GPU
  if [ -z "$M" ]; then
    echo "ERROR: $fn isn't in the form model.port.gpu.zip"
    exit 1
  fi
done

for fn in $MODELS
do

  if [ ! -f $fn ]; then
    continue
  fi

  F=$(basename $fn .zip) 
  M=$(echo $F | cut -f1 -d.) # Model
  P=$(echo $F | cut -f2 -d.) # Port
  G=$(echo $F | cut -f3 -d.) # GPU

  # stop the model (if it exists in any form - running, exited, etc)
  if [ "$(docker ps -a -q -f name=\^$M\$)" ]
  then
    echo $"stopping model $M"
    docker stop $M
    docker rm -f $M
  fi

  echo "deploying model $M, on port $P, using gpu $G ($fn)"
  $DEPLOY --model $M --port $P --gpu $G $fn

done
