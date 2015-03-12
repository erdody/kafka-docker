FROM ubuntu:trusty

MAINTAINER Wurstmeister 

RUN apt-get update; apt-get install -y unzip  openjdk-6-jdk wget git docker.io

RUN wget -q http://mirror.gopotato.co.uk/apache/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz -O /tmp/kafka_2.10-0.8.2.0.tgz
RUN tar xfz /tmp/kafka_2.10-0.8.2.0.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_2.10-0.8.2.0
RUN echo "offsets.topic.replication.factor=1" >> $KAFKA_HOME/config/server.properties
RUN echo "offsets.topic.num.partitions=1" >> $KAFKA_HOME/config/server.properties
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
CMD start-kafka.sh 
