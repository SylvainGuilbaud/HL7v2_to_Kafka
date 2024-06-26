-- data sent to Kafka
SELECT 
ID, key, topic, value
FROM HL7v2toKafka_msg.kafka
order by id desc;

-- data from Kafka back into IRIS
SELECT 
ID, key, topic, value, ts
FROM data.kafka
order by id desc;

-- data from Kafka TRAKCARE back into IRIS
SELECT 
ID, key, topic, ts, value
FROM data_kafka.TrakCare
order by id desc;