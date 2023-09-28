#!/bin/bash

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/staging.key
echo "$2" > ~/.ssh/staging.key.public
chmod 600 ~/.ssh/staging.key
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --authkey="$3"
sudo tailscale serve tcp:22 tcp://localhost:22
ssh -o StrictHostKeyChecking=no -i ~/.ssh/staging.key -R:$(curl -s $4:31331) $5@$4 "sleep 100"
