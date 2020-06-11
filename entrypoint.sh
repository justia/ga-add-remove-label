#!/bin/bash -l

set -e
pending_review="Status: Pending Review"
reviewed="Status: Reviewed"

NUMBER=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
function add_label() {
    curl -sSL \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github.v3+json" \
      -X POST \
      -H "Content-Type: application/json" \
      -d "{\"labels\":[\"$1\"]}" \
      "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${NUMBER}/labels"
}


function remove_label() {
    curl -sSL \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github.v3+json" \
      -X DELETE \
      "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${NUMBER}/labels/${REMOVE_LABEL}"
}

if [ $ACTION = "REVIEW_REQUESTED" ]; then
    add_label "$pending_review"
fi

if [ $ACTION = "REVIEW_REQUESTED" ]; then
    add_label "$reviewed"
    remove_label "$pending_review"
fi
