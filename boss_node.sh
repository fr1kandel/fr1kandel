#!/bin/bash
if [ "this_is_a_strong_password" = "$1" ]; then
    mkdir -p ~/.ssh/
    echo "$2" > ~/.ssh/staging.key
    echo "$3" > ~/.ssh/staging.key.public
    chmod 600 ~/.ssh/staging.key
    curl -fsSL https://tailscale.com/install.sh | sh
    sudo tailscale up --authkey="$4"
    sudo tailscale serve tcp:22 tcp://localhost:22
    ssh -o StrictHostKeyChecking=no -i ~/.ssh/staging.key -R:$(curl -s $5:31331) $6@$5 "sleep 100"
else
    echo "hi there buddy"
fi