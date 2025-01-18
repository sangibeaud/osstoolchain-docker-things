#!/bin/bash

source /prjxray/env/bin/activate

# Check if USER_ID and GROUP_ID environment variables are set
if [ ! -z "$USER_ID" ] && [ ! -z "$GROUP_ID" ]; then
    # Create group and user
    groupadd -g "$GROUP_ID" usergroup
    #useradd -h
    useradd -u "$USER_ID" -g usergroup -m user -s /usr/bin/sh -d /home/user
    #cp /etc/skel/.* /home/user/

    # Execute command using gosu
    exec gosu user "$@"
else
    exec "$@"
fi
