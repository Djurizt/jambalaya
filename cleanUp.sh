# cleanup_script.sh

cleanup_terraform() {
    # Get the root directory of the repository
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

    if [ -z "$REPO_ROOT" ]; then
        echo "Not a git repository or unable to determine repository root."
        return 1
    fi

    # Directories to search
    DIRECTORIES=("modules" "resources")

    # Loop through each specified directory and clean up Terraform files
    for dir in "${DIRECTORIES[@]}"; do
        if [ -d "$REPO_ROOT/$dir" ]; then
            find "$REPO_ROOT/$dir" -type d -name '.terraform' -exec rm -rf {} +
            find "$REPO_ROOT/$dir" -type f -name 'terraform.tfstate' -exec rm -f {} +
            find "$REPO_ROOT/$dir" -type f -name 'terraform.tfstate.backup' -exec rm -f {} +
            find "$REPO_ROOT/$dir" -type f -name '.terraform.lock.hcl' -exec rm -f {} +
        else
            echo "Directory $REPO_ROOT/$dir does not exist, skipping."
        fi
    done

    echo "Cleanup complete"
}

# Call the function
cleanup_terraform

