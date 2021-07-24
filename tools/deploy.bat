gcloud beta run deploy sentryhooks --source=. --project=sky-message-api --port=8080 --args="--port 8080" --concurrency=3 --max-instances=3 --region=europe-west4 --platform managed --timeout=7s --cpu=1 --memory=64Mi --no-use-http2 --allow-unauthenticated