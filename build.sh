#!/usr/bin/env bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"

do_build() {
  VER=$1
  SED_REPLACE_VER=$VER
  if [ "x$VER" == "xlatest" ]; then
    SED_REPLACE_VER=8
  fi
  DEST_FOLDER=${DIR}/ver-$VER
  mkdir -p ${DEST_FOLDER}
  echo "building --- Version: " $VER "-->";
  DEST_FILE=${DEST_FOLDER}/Dockerfile

  for i in "" .app; 
    do cp Dockerfile${i} ${DEST_FILE}${i};
    sed -i -e "s|\[VERSION\]|$SED_REPLACE_VER|g" ${DEST_FILE}${i};
    if [ -e "${DEST_FILE}${i}-e" ]; then rm ${DEST_FILE}${i}-e; fi;
  done;
}

do_build $1 
