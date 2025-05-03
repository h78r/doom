#!/bin/bash
# H78R Systems

# Check if DEPLOY_DIR is defined
if [ -z "$DEPLOY_DIR" ]; then
  echo "Error: DEPLOY_DIR is not defined."
  echo "Please set it using: export DEPLOY_DIR=/your/deploy/path"
  exit 1
fi

# Get a safe name for use in the backup file
DEPLOY_NAME=$(basename "$DEPLOY_DIR" | tr '.' '_')

echo "Performing git pull in $DEPLOY_DIR/staging/doom..."
cd "$DEPLOY_DIR/staging/doom" || { echo "Directory not found!"; exit 1; }
git pull

timestamp=$(date +"%Y%m%d_%H%M%S")
backup_file=~/"${DEPLOY_NAME}_backup_${timestamp}.zip"

cd "$DEPLOY_DIR" || exit 1
echo "Creating backup: $backup_file"
zip -r "$backup_file" . -x "staging/*"

echo "Cleaning up $DEPLOY_DIR except 'staging'..."
find "$DEPLOY_DIR" -mindepth 1 -maxdepth 1 ! -name "staging" -exec rm -rf {} +

echo "Deploying from $DEPLOY_DIR/staging/doom to live..."
cp -a "$DEPLOY_DIR/staging/doom/dist/." "$DEPLOY_DIR/"

echo "Deployment to '$DEPLOY_DIR' complete."
