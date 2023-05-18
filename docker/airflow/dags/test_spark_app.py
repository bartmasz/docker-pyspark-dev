from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder.appName("pyspark test app").getOrCreate()
# data = [{"name": "Alice", "age": 1}, {"name": "Bob", "age": 2}]
# spark.createDataFrame(data).show(10, 0)

df = spark.read.options(delimiter=",", header=True).csv("/data/us_electric_cars.csv")
output_df = df.groupby("Make", "Model").count().sort(F.desc("count"))
output_df.show(20, 0)
output_df.write.options(delimiter=",", header=True).csv("/data/car_analysis")
