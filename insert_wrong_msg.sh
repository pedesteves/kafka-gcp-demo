(echo -n "1|"; cat wrong_message.json | jq . -c) | /opt/kafka/bin/kafka-console-producer.sh \
	--broker-list localhost:9092 \
	--topic txtopicv2 \
	--property "parse.key=true" \
	--property "key.separator=|"
