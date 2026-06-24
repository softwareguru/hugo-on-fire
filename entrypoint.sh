# Displaying versions
node -v
firebase --version
hugo version

# Export google application credentials
if [ -z "$GCP_SA_KEY" ] && [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
  echo "Either GCP_SA_KEY or GOOGLE_APPLICATION_CREDENTIALS is required to run commands with the firebase cli"
  exit 126
fi

if [ -n "$GCP_SA_KEY" ]; then
  if echo "$GCP_SA_KEY" | jq empty 2>/dev/null; then
    echo "Storing GCP_SA_KEY in /opt/gcp_key.json"
    echo "$GCP_SA_KEY" > /opt/gcp_key.json
  else
    echo "Storing the decoded GCP_SA_KEY in /opt/gcp_key.json"
    echo "$GCP_SA_KEY" | base64 -d > /opt/gcp_key.json # If encoded base64 key, decode and save
  fi

  echo "Exporting GOOGLE_APPLICATION_CREDENTIALS=/opt/gcp_key.json"
  export GOOGLE_APPLICATION_CREDENTIALS=/opt/gcp_key.json
fi

# Generate hugo site
hugo

# Deploy it on Firebase
echo "About to try to deploy using $GOOGLE_APPLICATION_CREDENTIALS"
firebase deploy
