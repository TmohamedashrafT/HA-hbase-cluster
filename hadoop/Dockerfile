FROM ubuntu:24.04

# Install dependencies in a single layer with cleanup
RUN apt-get update && \
    apt-get install -y  \
        curl \
        wget \
        sudo \
        openjdk-8-jdk \
        tar \
        netcat-openbsd
		

# Configure user and permissions
RUN adduser --disabled-password --gecos "" hadoop && \
    echo "hadoop:hadoop" | chpasswd && \
    adduser hadoop sudo && \
    echo "hadoop ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_HOME=/home/hadoop/packages/hadoop 
ENV ZOOKEEPER_HOME=/home/hadoop/packages/zookeeper
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop 
ENV HADOOP_LOG_DIR=/home/hadoop/hadoop/logs 
ENV ZOO_LOG_DIR=/home/hadoop/zookeeper/logs 
ENV HADOOP_USER_NAME=root 
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$ZOOKEEPER_HOME/bin

WORKDIR /home/hadoop/

# Create directory structure
RUN mkdir -p \
    /home/hadoop/hadoop/logs \
    /home/hadoop/zookeeper/{logs,data} \
    /home/hadoop/packages

# Download and extract Hadoop and ZooKeeper with checksum verification
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    wget https://downloads.apache.org/zookeeper/zookeeper-3.8.4/apache-zookeeper-3.8.4-bin.tar.gz && \
    tar -xzf hadoop-3.3.6.tar.gz -C /home/hadoop/packages/ && \
    tar -xzf apache-zookeeper-3.8.4-bin.tar.gz -C /home/hadoop/packages/ && \
    mv /home/hadoop/packages/hadoop-3.3.6 $HADOOP_HOME && \
    mv /home/hadoop/packages/apache-zookeeper-3.8.4-bin $ZOOKEEPER_HOME && \
    rm -f *.tar.gz

# Copy configuration files with proper permissions
COPY  configs/hadoop_config/ $HADOOP_HOME/etc/hadoop/
COPY  configs/zoo.cfg $ZOOKEEPER_HOME/conf/
COPY  gcp.json /home/hadoop/gcp.json
COPY  entrypoint.sh ./home/hadoop/entrypoint.sh


VOLUME ["/home/hadoop/main"]


ENTRYPOINT ["./home/hadoop/entrypoint.sh"]