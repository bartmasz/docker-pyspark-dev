FROM spark_base

# Set default environment variables. These can also be set at the command line when invoking /bin/spark-submit
ENV MASTER_CONTAINER_NAME=spark-master
ENV SPARK_EXECUTOR_MEMORY=2G
ENV SPARK_EXECUTOR_CORES=1

# Install libraries
COPY ./docker/spark/resources/requirements.txt .
RUN pip install -r requirements.txt

# Copy examples python files into container
# COPY ./examples/ /home/examples/
COPY /docker/spark/resources/log4j.properties /docker/spark/resources/spark-defaults.conf $SPARK_HOME/conf/
COPY /docker/spark/resources/test_spark_app.py /home/

# ENV PATH="$PATH:$SPARK_HOME/bin"

EXPOSE 4040

WORKDIR /home/


# ENTRYPOINT ["tail"]
# CMD ["-f","/dev/null"]
CMD [ "airflow", "standalone" ]