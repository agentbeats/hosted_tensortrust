#!/usr/bin/env bash

set -e

# TODO: not checking healthcheck port for now

# in case user needs customized packages: /workspace/requirements.txt
if [ -f /workspace/requirements.txt ]; then
  pip install -r /workspace/requirements.txt
fi

# let container's 127.0.0.1:9000-9001 be accessible from host
for port in $(seq 9000 9001); do
    socat TCP-LISTEN:$port,bind=127.0.0.1,fork,reuseaddr \
          TCP:host.docker.internal:$port &
done

# load scenario
ab load_scenario "/workspace/agent"
