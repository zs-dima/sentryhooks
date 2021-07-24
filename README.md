# sentryhooks  

Sending Sentry WebHooks messages to the Telegram messenger.

Own Telegram bot have to be created to receive messages.

Telegram token & chat id have to be set up as environments (have to be moved to secrets later)
  
  
### Setup project:  

**{{PROJECT ID}}** - your Google Cloud project Id

Set environment variables values:

**{{CODE}}** - Security code (any string) to use as URL parameter 'code' value.

**{{TELEGRAM TOKEN}}** - Telegram token

**{{TELEGRAM CHAT}}** - Telegram chat id


### Hot to run locally:  
  
```shell  
dart run .\bin\server.dart --port 8080  
```  
  
  
### Google Cloud Run setup
  
[Quickstart](https://github.com/GoogleCloudPlatform/functions-framework-dart/blob/main/docs/quickstarts/03-quickstart-cloudrun.md)  
[Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install)  
```shell  
gcloud auth login  
gcloud config set core/project {{PROJECT ID}}
gcloud config set run/platform managed  
gcloud config set run/region europe-west4  
```  
  
  
### Deploy:  
  
[gcloud beta run deploy](https://cloud.google.com/sdk/gcloud/reference/beta/run/deploy)  
```shell  
gcloud beta run deploy sentryhooks \  
  --source=. \                            # can use $PWD or . for current dir  
  --project=sky-message-api \             # the Google Cloud project ID  
  --port=8080 \                           # Container port to receive requests at. Also sets the $PORT environment variable.  
  --args='--port 8080' \                  #  
  --set-env-vars='CODE={{CODE}},TELEGRAM_TOKEN={{TELEGRAM TOKEN}},TELEGRAM_CHAT={{TELEGRAM CHAT}}' \ # Set certain CODE, TELEGRAM_TOKEN & TELEGRAM_CHAT values
  --concurrency=3 \                       #  
  --max-instances=3 \                     #  
  --region=europe-west4 \                 # ex: us-central1  
  --platform managed \                    # for Cloud Run  
  --timeout=25s \                         # Set the maximum request execution time (timeout).  
  --cpu=1 \                               # Set a CPU limit in Kubernetes cpu units.  
  --memory=64Mi \                         #  
  --no-use-http2 \                        #  
  --allow-unauthenticated                 # for public access  
```
