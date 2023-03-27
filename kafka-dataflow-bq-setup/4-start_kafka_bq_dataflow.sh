export PROJECT=generic-demos
export REGION=us-central1
export BUCKET_NAME=gs://kafka-bq-dataflow
export OUTPUT_TABLE=${PROJECT}:kafka_to_bigquery.transactions
export JS_PATH=${BUCKET_NAME}/my_function.js
export JS_FUNC_NAME=transform
export TEMPLATE_MODULE=kafka-to-bigquery
export TOPICS=txtopicv2
export BOOTSTRAP=10.128.0.47:9092
export JOB_NAME="${TEMPLATE_MODULE}-`date +%Y%m%d-%H%M%S-%N`"

gcloud beta dataflow flex-template run $TEMPLATE_MODULE \
    --project=$PROJECT \
    --region=$REGION \
    --template-file-gcs-location=gs://dataflow-templates/latest/flex/Kafka_to_BigQuery \
    --parameters \
outputTableSpec=$OUTPUT_TABLE,\
inputTopics=$TOPICS,\
javascriptTextTransformGcsPath=$JS_PATH,\
javascriptTextTransformFunctionName=$JS_FUNC_NAME,\
bootstrapServers=$BOOTSTRAP
  
