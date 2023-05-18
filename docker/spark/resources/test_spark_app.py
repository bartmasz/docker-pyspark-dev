from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("pyspark test app").getOrCreate()
data = [{"name": "Alice", "age": 1}, {"name": "Bob", "age": 2}]
spark.createDataFrame(data).show(10, 0)
