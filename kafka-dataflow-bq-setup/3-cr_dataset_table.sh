bq mk --location US --dataset kafka_to_bigquery
bq mk --table \
--schema schema.json \
--time_partitioning_field transaction_time \
kafka_to_bigquery.transactions

