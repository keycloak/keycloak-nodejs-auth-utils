#!/bin/bash

set -v

echo $CWD
. test/scripts/version.sh
ARCHIVE="${KEYCLOAK}.tar.gz"
URL="http://downloads.jboss.org/keycloak/${VERSION}/${ARCHIVE}"

# Download keycloak server if we don't already have it
#if [ ! -e $KEYCLOAK ]
#then
#  wget $URL
  tar xvzf $ARCHIVE
#fi

# Start the server
${KEYCLOAK}/bin/standalone.sh -Djava.net.preferIPv4Stack=true > keycloak.log 2>&1 &

# Save the PID so we can kill it scriptually later
PID=$!
echo "Server PID $PID"
echo $PID | cat > keycloak.pid

# Try to add an initial admin user, so we can test against
# the server and not get automatically redirected.
${KEYCLOAK}/bin/add-user.sh -r master -u admin -p admin
waitForServer

# We have to restart the server for the admin user to load?
${KEYCLOAK}/bin/jboss-cli.sh --connect command=:reload
waitForServer
