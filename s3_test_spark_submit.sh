#!/usr/bin/sh

docker exec -ti spark-submit /spark/bin/spark-submit --conf spark.executor.memory=1G --conf spark.executor.cores=1 --master spark://spark-master:7077 /home/test_spark_app.py