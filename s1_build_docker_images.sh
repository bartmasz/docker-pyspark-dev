#!/usr/bin/sh
docker build -f docker/spark/base.Dockerfile -t spark_base .
docker build -f docker/spark/master.Dockerfile -t spark_master .
docker build -f docker/spark/worker.Dockerfile -t spark_worker .
docker build -f docker/spark/submit.Dockerfile -t spark_submit .
