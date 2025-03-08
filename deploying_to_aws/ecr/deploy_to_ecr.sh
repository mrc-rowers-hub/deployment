#!/bin/bash

if [ -z "$AWS_ACCOUNT_ID" ]; then
  read -p "Please enter your AWS Account ID: " AWS_ACCOUNT_ID
fi

AWS_REGION="eu-west-1"
ECR_REPOS=("crm-repo" "resources-repo" "scheduler-repo" "members-hub-repo" "condition-checker-repo")
REPO_PATHS=(
    "../../../mrc-condition-checker/condition-checker"
    "../../../mrc-crm"
    "../../../mrc-resources"
    "../../../mrc-scheduler-service/scheduler-service"
    "../../../mrc-members-hub/row-your-boat"
)

# Authenticate Docker to AWS ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Loop over all repositories and build and push the image for each
for i in "${!ECR_REPOS[@]}"; do
    REPO="${ECR_REPOS[$i]}"
    REPO_PATH="${REPO_PATHS[$i]}"

    # Check if Dockerfile exists
    if [ -f "$REPO_PATH/Dockerfile" ]; then
        # Build and tag Docker image for the repo
        echo "Building Docker image for $REPO from $REPO_PATH"
        docker build -t $REPO "$REPO_PATH"  # Build context is the path to the project folder containing the Dockerfile
        docker tag $REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest

        # Push the image to ECR
        docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO:latest
        echo "Successfully pushed $REPO to ECR"
    else
        echo "Dockerfile not found in $REPO_PATH. Skipping repository $REPO"
    fi
done
