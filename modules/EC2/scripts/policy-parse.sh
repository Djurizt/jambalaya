#!/bin/bash

# Load the policy document
policy_file="policy.json"

sudo apt update
sudo apt install -y jq

# Check if jq is installed (for parsing JSON)
if ! command -v jq &> /dev/null; then
    echo "jq could not be found. Please install jq to continue."
fi

# Traverse and print each statement in the policy document
echo "Traversing IAM Policy Document:"
jq -c '.value.Statement[]' "$policy_file" | while read -r statement; do
    # Extract Effect, Action, Resource, and Condition
    effect=$(echo "$statement" | jq -r '.Effect')
    actions=$(echo "$statement" | jq -r '.Action')
    resources=$(echo "$statement" | jq -r '.Resource')
    conditions=$(echo "$statement" | jq -r '.Condition // empty')

    echo "Effect: $effect"
    echo "Actions: $actions"
    echo "Resources: $resources"

    if [ -n "$conditions" ]; then
        echo "Conditions:"
        echo "$conditions" | jq -r 'to_entries[] | "  - \(.key): \(.value)"'
    fi

    echo "---"
done
