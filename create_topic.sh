/opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 \
	--replication-factor 1 \
	--partitions 1 --topic txtopicv2

/opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092
