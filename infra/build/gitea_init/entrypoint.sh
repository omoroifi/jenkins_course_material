#!/bin/bash

set -x
set -e
set -u
set -o pipefail

GITHUB_REPOSITORIES=(
    omoroifi/calculator-unit-test-example-java
    omoroifi/webcalc
)

source ${USER_CREDS}

digest=$(echo -n "$USERNAME:$PASSWORD" | base64)
host=${host:-gitea}

get_uid() {
    curl -X GET "http://${host}:3000/api/v1/user" \
	 -H  "accept: application/json" \
	 -H  "authorization: Basic $digest" | jq .id
}

wait_for_service() {
    while ! get_uid; do
        sleep 1
    done
    sleep 3
}

migrate_repo() {
    local repo=$1
    local repo_name=$(basename $repo)
    local uid=$(get_uid)
    curl --fail -X POST "http://${host}:3000/api/v1/repos/migrate" \
	 -H  "accept: application/json" \
	 -H  "authorization: Basic ${digest}" \
	 -H  "Content-Type: application/json" \
	 -d  '{
                 "clone_addr": "https://github.com/'$repo'",
		 "description": "'$repo_name'",
		 "issues": false,
		 "labels": false,
		 "milestones": false,
		 "mirror": false,
		 "private": true,
		 "pull_requests": false,
		 "releases": false,
		 "repo_name": "'$repo_name'",
		 "service": 0,
		 "uid": '$uid',
		 "wiki": false
	     }'

}

wait_for_service

for repo in "${GITHUB_REPOSITORIES[@]}"; do
    migrate_repo "$repo"
done
