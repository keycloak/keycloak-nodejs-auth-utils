#!/bin/bash

set -v

export VERSION="1.9.2.Final"
export KEYCLOAK="keycloak-${VERSION}"

function waitForServer {
  # Give the server some time to start up. Look for a well-known
  # bit of text in the log file. Try at most 50 times before giving up.
  C=50
  while [ $C -gt 0 ]
  do
    grep "Keycloak ${VERSION} (WildFly Core 2.0.10.Final) started" keycloak.log
    FOUND=$?
    if [ $FOUND -eq 0 ]; then
      echo "Server started."
      C=0
    else
      echo -n "${C}."
      C=$(( $C - 1 ))
    fi
    sleep 1
  done
}