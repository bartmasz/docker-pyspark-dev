FROM python:3.11-slim
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openjdk-11-jre-headless wget iputils-ping \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
RUN wget https://dlcdn.apache.org/spark/spark-3.4.0/spark-3.4.0-bin-hadoop3-scala2.13.tgz
RUN tar -xzvf spark-3.4.0-bin-hadoop3-scala2.13.tgz
RUN rm spark-3.4.0-bin-hadoop3-scala2.13.tgz
RUN mv /spark-3.4.0-bin-hadoop3-scala2.13 /spark
RUN pip install --no-cache-dir apache-airflow-providers-apache-spark==4.0.1
RUN mkdir /data

ENV SPARK_HOME=/spark
ENV PATH="$PATH:$SPARK_HOME/bin"
# ENTRYPOINT ["tail"]
# CMD ["-f","/dev/null"]