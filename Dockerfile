# Base image
FROM hadoop:latest


WORKDIR /home/hadoop/

ENV HBASE_VERSION=2.4.9

ADD https://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz /home/hadoop/packages/
RUN tar -xzf /home/hadoop/packages/hbase-${HBASE_VERSION}-bin.tar.gz -C /home/hadoop/packages && \
    mv /home/hadoop/packages/hbase-${HBASE_VERSION} /home/hadoop/packages/hbase && \
    rm  /home/hadoop/packages/hbase-${HBASE_VERSION}-bin.tar.gz

# Environment variables
ENV HBASE_HOME=/home/hadoop/packages/hbase
ENV PATH=$PATH:$HBASE_HOME/bin

# Expose HBase ports
EXPOSE 16000 16010 16020

COPY hbase-site.xml /home/hadoop/packages/hbase/conf/

COPY  entrypoint.sh ./home/hadoop/entrypoint.sh

ENTRYPOINT ["./home/hadoop/entrypoint.sh"]


