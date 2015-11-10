# DOCKER-VERSION 1.9.0

# run as docker -e "myid=<myid>" -d sauverma/zkquorum

FROM ubuntu
MAINTAINER saurabh.verma@zeotap.com

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper \
    && apt-get install -y vim 

ENV TERM dumb
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV tickTime 5000
ENV server1 zookeeper_zk1_1:2888:3888
ENV server2 zookeeper_zk2_1:2888:3888
ENV server3 zookeeper_zk3_1:2888:3888

RUN sed -i '/tickTime=/c\tickTime='$tickTime'' /opt/zookeeper/conf/zoo.cfg
RUN echo server.1=${server1} >> /opt/zookeeper/conf/zoo.cfg
RUN echo server.2=${server2} >> /opt/zookeeper/conf/zoo.cfg
RUN echo server.3=${server3} >> /opt/zookeeper/conf/zoo.cfg

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

ADD init.sh /opt/zookeeper/bin/init.sh
RUN chmod 777 /opt/zookeeper/bin/init.sh

CMD /opt/zookeeper/bin/init.sh
