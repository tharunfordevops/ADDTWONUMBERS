#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2


validate_args()

# Function to make a GET request to the GitHub API (issues only)
function github_api_get_issues() {
    local org="$1"
    local repo="$2"
    local endpoint="repos/${org}/${repo}/issues"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to GitHub API with authentication
    curl -s -L \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${TOKEN}" \
        "$url"
}

# Function to list issues on a repository inside an organization
function list_repo_issues() {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/issues"

    # Fetch the list of issues
    issues="$(github_api_get "$endpoint")"

    # Display the list of issues
    if [[ -z "$issues" ]]; then
        echo "No issues found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Issues for ${REPO_OWNER}/${REPO_NAME}:"
        echo "$issues"
    fi
}


# Helper function to check if two arguments are passed
function validate_args() {
    if [ $# -ne 2 ]; then
        echo "Error: Please enter two numbers"
        exit 1
    fi
}


# --- MAIN EXECUTION ---
echo "Fetching issues for $REPO_OWNER/$REPO_NAME ..."
github_api_get_issues "$REPO_OWNER" "$REPO_NAME"
