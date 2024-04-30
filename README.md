 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/hl7v2-to-kafka)

## Production Configuration

This demo has an interoperability [production](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/production.cls) with 3 HL7 Business Services one HL7 ROUTER and 3 Business Operations, include one sending the transformed messages to Kafka.
<img width="1411" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/ProductionConfigurationAll.jpg?raw=true">

## Business Rule

The production has a business process with is a [HL7 router](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/HL7router/SIU.cls), which transforms and send HL7 message to Kafka. 
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/RuleEditor.jpg?raw=true">

## Data Transformation

The Data Transformation Builder allows the edition of the definition of a transformation between HL7v2 SIU sources into Kafka Messages.
[Data Transformation](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/src/HL7v2toKafka/transfo/SIU.cls)
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/Transfo.jpg?raw=true">

## Visual Trace
After an HL7 message has been processed, ie: by copying some messages from [/data/HL7/test](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/tree/main/data/HL7/test) into [/data/HL7/in](https://github.com/SylvainGuilbaud/hl7v2-to-kafka/tree/main/data/HL7/in) directory), you can see its Visual Trace
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace1.jpg?raw=true">
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/VisualTrace2.jpg?raw=true">

## Kafka Manager
Then, you can check the messages in Kafka, using KafkaManager interface and fetching data from the different topics.
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/KafkaManager1.jpg?raw=true">
<img width="864" src="https://github.com/SylvainGuilbaud/hl7v2-to-kafka/blob/main/images/KafkaManager2.jpg?raw=true">


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

