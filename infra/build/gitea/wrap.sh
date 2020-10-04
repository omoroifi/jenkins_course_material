#!/bin/bash

init_user() {
    while ! timeout 1 bash -c "echo > /dev/tcp/localhost/3000"; do
        sleep 1
    done
    source "${USER_CREDS}"
    gitea admin create-user --admin --access-token --username="${USERNAME}" --password="${PASSWORD}" --email=user@example.local --must-change-password=false
}

init_user &
/usr/bin/entrypoint $@
