#!/bin/bash

set -v

. test/scripts/version.sh

${KEYCLOAK}/bin/jboss-cli.sh --connect command=:shutdown