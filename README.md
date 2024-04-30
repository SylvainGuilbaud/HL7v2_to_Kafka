 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/hl7v2-to-kafka)

## Production Configuration

This demo has an interoperability [production](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/production.cls) with 16 items.
<img width="1411" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/ProductionConfigurationAll.jpg?raw=true">

## Production Configuration HL7 + Kafka Producer
The first part of this demonstration consists of sending an HL7 SIU file which will be transmitted to the 2 other HL7 flows (HTTP and TCP), and transformed and transmitted to the Kafka server. 
HTTP and TCP flows will transform HL7 messages in the same way before sending them to Kafka as well.
* 3 HL7 Business Services 
* 1 HL7 router 
* 2 HL7 Business Operations
* one Business Operation sending the transformed messages to Kafka
<img width="1411" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/ProductionConfigurationHL7.jpg?raw=true">

## Business Rule

The production has a business process with is a [HL7 router](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/HL7router/SIU.cls), which transforms and sends HL7 message to Kafka. 
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/RuleEditor.jpg?raw=true">

## Data Transformation

The Data Transformation Builder allows the edition of the definition of a transformation between HL7v2 SIU sources into Kafka Messages.
[Data Transformation](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/transfo/SIU.cls)
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/Transfo.jpg?raw=true">

## Visual Trace
After an HL7 message has been processed, ie: by copying some messages from [/data/HL7/test](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/tree/main/data/HL7/test) into [/data/HL7/in](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/tree/main/data/HL7/in) directory), you can see its Visual Trace
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace01.jpg?raw=true">
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace02.jpg?raw=true">
You can see here the message with I/O and the HL7 ACK
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace05.jpg?raw=true">

## Kafka Manager
Then, you can check the messages in Kafka, using KafkaManager interface and fetching data from the different topics.
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/KafkaManager01.jpg?raw=true">
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/KafkaManager02.jpg?raw=true">

## Production Configuration Kafka Consumer + SQL IRIS
The second part of this demonstration consists of consuming Kafka messages and route them to IRIS tables through SQL components. 
* 3 Kafka Business Services consuming 3 Topics of Kafka
* 1 router 
* 3 SQL Business Operations inserting data into IRIS database
<img width="1411" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/ProductionConfigurationKafka.jpg?raw=true">

## Business Rule

The production has a business process with is a [Kafka router](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/rules/Kafka.cls), which sends Kafka messages to IRIS SQL components. 
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/RuleEditorKafka.jpg?raw=true">

## Visual Trace
Each time a Kafka topic is consumed, it is sent to the Kafka router process which performs content-based routing of Kafka messages, to the appropriate SQL tables into IRIS.
If you look carefully to the messages, you can notice that the message is sent directly to IRIS without being transformed (same message ID).
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace03.jpg?raw=true">
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace04.jpg?raw=true">


## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation: ZPM

Open IRIS Namespace with Interoperability Enabled.
Open Terminal and call:
USER>zpm "install hl7v2-to-kafka"

## Installation: Docker
Clone/git pull the repo into any local directory

```
$ git clone https://github.com/SylvainGuilbaud/hl7v2-to-kafka.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```



## How to Run the Sample
1. copy some HL7 messages from /data/HL7/test into /data/HL7/in
2. check the [Visual Trace](http://localhost:8888/csp/healthshare/irisapp/EnsPortal.MessageViewer.zen?$NAMESPACE=IRISAPP&$NAMESPACE=IRISAPP&)
3. see a [full trace](http://localhost:8888/csp/healthshare/irisapp/EnsPortal.VisualTrace.zen?SESSIONID=2)
4. go to [Kafka Manager](http://localhost:8082/topics) and fetch data from the different topics

