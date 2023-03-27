

if [ $# -ne 1 ]
then
 echo "Please specify how many messages to insert !" 
 echo "example: ./$0 3" 
 echo "This will generate 3 messages in the Kafka topic of choice" 
 exit 0
fi

CC_STDATE="2020-01-01"
NOW=$(date +"%Y-%m-%d %H:%M:%S")
MAX_ID=1000
MAX_PRICE=10000
#MAX_LOOP=10
MAX_LOOP=$1
#KAFKA_SERVER=10.128.0.47
KAFKA_SERVER=localhost
KAFKA_TOPIC=txtopicv2

lcounter=1

arrcountry[0]="US"
arrcountry[1]="BR"
arrcountry[2]="CA"
arrcountry[3]="FR"

arrstate[0]="FL"
arrstate[1]="NY"
arrstate[2]="CT"
arrstate[3]="CA"


arrcc[0]="4444-4444-4444-4444"
arrcc[1]="2332-3444-5694-5098"

arraddress[0]="23 Monroy St"
arraddress[1]="45 Country St"
arraddress[2]="56 Oliver ct St"
arraddress[3]="97 Old Brick Road"

arrcity[0]="Oviedo"
arrcity[1]="New York City"
arrcity[2]="Miami"
arrcity[3]="Babylon"

#rand=$[$RANDOM % ${#arr[@]}]
#echo $(date)
#echo ${arr[$rand]}

while [ $lcounter -le $MAX_LOOP ]
do
   CC_STDATE=`date -d "2012-01-01 + $lcounter days" +'%Y-%m-%d'`
   #R_COUNTRY=$[$RANDOM % ${#arrcountry[@]}]
   R_COUNTRY=`echo ${arrcountry[$RANDOM % ${#arrcountry[@]}]}`
   R_CITY=`echo ${arrcity[$RANDOM % ${#arrcity[@]}]}`
   R_STATE=`echo ${arrstate[$RANDOM % ${#arrstate[@]}]}`
   R_CC=`echo ${arrcc[$RANDOM % ${#arrcc[@]}]}`
   R_ADD=`echo ${arraddress[$RANDOM % ${#arraddress[@]}]}`
   R_PRICE1=$(($RANDOM%$MAX_PRICE))
   R_PRICE2=$(($RANDOM%$MAX_PRICE))
   FNAME=`./generate_random_words.sh 1`
   LNAME=`./generate_random_words.sh 1`
   ADDRESS=`./generate_random_words.sh 1`
   CITY=`./generate_random_words.sh 1`
   CC=`./generate_random_words.sh 1`
   CCEXP=`./generate_random_words.sh 1`
   COUNTRY=`./generate_random_words.sh 1`
   PNAME1=`./generate_random_words.sh 1`
   PNAME2=`./generate_random_words.sh 1`

   MSG="{\"transaction_time\": \"${NOW}\",\"first_name\": \"${FNAME}\", \"last_name\": \"${LNAME}\",\"credit_card_expiration\": \"${CC_STDATE}\",\"credit_card_number\": \"${R_CC}\",\"address\": \"${R_ADD}\",\"city\": \"${R_CITY}\", \"state\": \"${R_STATE}\",\"country\": \"${R_COUNTRY}\", \"products\": [ { \"product_name\": \"${PNAME1}\", \"product_price\": ${R_PRICE1} }, { \"product_name\": \"${PNAME2}\", \"product_price\": ${R_PRICE2} } ] } "

   echo $MSG > tmp_message.json

   cat tmp_message.json

   (echo -n "1|"; cat tmp_message.json | jq . -c) | /opt/kafka/bin/kafka-console-producer.sh \
   --broker-list $KAFKA_SERVER:9092 \
   --topic $KAFKA_TOPIC \
   --property "parse.key=true" \
   --property "key.separator=|"

   lcounter=$((lcounter+1))
done
