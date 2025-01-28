### Steps for python image which autmatically ingests data to postgres db

# Create a Dockerfile following https://www.youtube.com/watch?v=B1WwATwf-vY&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=9
# In dockerfile include installation of wget and sqlalchemy + psycopg2-binary
# Add downloading of the .parqet data file with os + wget (https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet)
# Add argparse commands for starting the script


import argparse
import os
import pandas as pd
from sqlalchemy import create_engine


def main(args):
    """NY taxi data ingestion"""
    user = args.user
    password = args.password
    host = args.host
    port = args.port
    db = args.db
    table = args.table_name

    os.system(
        "wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet -O yellow_tripdata_2021-01.parquet"
    )

    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")
    engine.connect()
    print("Pgsql engine connected.")

    df = pd.read_parquet("./yellow_tripdata_2021-01.parquet")
    df.to_sql(name=table, con=engine, if_exists="replace")
    print("NY taxi data ingested.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ingest parquet data to Postgres")
    parser.add_argument("--user", help="User name for postgres")
    parser.add_argument("--password", help="Password for postgres")
    parser.add_argument("--host", help="Host for postgres", default="localhost")
    parser.add_argument("--port", help="Port for postgres", default="5432")
    parser.add_argument("--db", help="Database name for postgres", default="ny_taxi")
    parser.add_argument(
        "--table_name",
        help="Table to ingest data to",
        default="yellow_taxi_data",
    )

    args = parser.parse_args()
    print(args)
    main(args)
