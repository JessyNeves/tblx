import os
from pyspark.sql import SparkSession
from pyspark.storagelevel import StorageLevel
from common_lib import check_and_enforce_schema
import importlib
import sys
import json

if __name__ == '__main__':

    spark = SparkSession\
        .builder\
        .appName("tblx")\
        .getOrCreate()

    prepare = int(sys.argv[3])
    if prepare:
        # Drop extra column created due to trailing comma.
        raw_data = spark.read.option("header", "true").csv("./data/raw_layer").drop("_c12")
        raw_data.repartition(2)

        # Check and enforce Dataframe schema.
        raw_data = check_and_enforce_schema(raw_data, "flight_data")
        # Rewrite as partitioned parquet.
        raw_data.write\
            .partitionBy("YEAR", "MONTH")\
            .mode("overwrite")\
            .parquet("./data/prepared_layer")

    # Ingest prepared layer
    prepared_data = spark.read.parquet("./data/prepared_layer")

    # Check and enforce schema
    prepared_data = check_and_enforce_schema(prepared_data, "flight_data")
    # Local single node cluster.
    prepared_data.persist(StorageLevel.MEMORY_AND_DISK)

    # Name for Temporary View
    tmp_view = "flight_statistics"
    prepared_data.createOrReplaceTempView(tmp_view)

    # Calculate defined queries
    for sql_file in os.listdir("./sql/"):
        with open(f"./sql/{sql_file}") as query:
            try:
                print(f"Answer to question {sql_file[0]} -> {sql_file[2:-4].upper()}")
                # Replace paramerizable values before executing query.
                formatted_query = query.read().format(
                    ORIGIN_AIRPORT = sys.argv[1].upper(),
                    DESTINATION_AIRPORT = sys.argv[2].upper(),
                    SOURCE = tmp_view
                )

                df = spark.sql(formatted_query)
                df.show(50)

            except Exception as e:
                print(e)

