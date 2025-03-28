import csv
import json
from time import time
from typing import List, Dict
from kafka import KafkaProducer
from kafka.errors import KafkaTimeoutError

from ride import Ride
from settings import BOOTSTRAP_SERVERS, INPUT_DATA_PATH, KAFKA_TOPIC

# INPUT_DATA_PATH = "../data/green_tripdata_sample.csv"
INPUT_DATA_PATH = "../data/green_tripdata_2019-10.csv"

class JsonProducer(KafkaProducer):
    def __init__(self, props: Dict):
        self.producer = KafkaProducer(**props)

    @staticmethod
    def read_records(resource_path: str):
        records = []
        with open(resource_path, 'r') as f:
            reader = csv.reader(f)
            header = next(reader)  # skip the header row
            for row in reader:
                # print(row)
                records.append(Ride(arr=row))
                # print(Ride(row))
        return records

    def publish_rides(self, topic: str, messages: List[Ride]):
        for ride in messages:
            try:
                record = self.producer.send(topic=topic, key=ride.PULocationID, value=ride)
                print('Record {} successfully produced at offset {}'.format(ride.PULocationID, record.get().offset))
            except KafkaTimeoutError as e:
                print(e.__str__())


if __name__ == '__main__':
    # Config Should match with the KafkaProducer expectation
    # kafka expects binary format for the key-value pair
    config = {
        'bootstrap_servers': BOOTSTRAP_SERVERS,
        'key_serializer': lambda key: str(key).encode(),
        'value_serializer': lambda x: json.dumps(x.__dict__, default=str).encode('utf-8')
    }
    producer = JsonProducer(props=config)
    rides = producer.read_records(resource_path=INPUT_DATA_PATH)
    print(rides)
    # t0 = time()
    # producer.publish_rides(topic=KAFKA_TOPIC, messages=rides)
    # producer.flush()
    # t1 = time()
    # took = t1 - t0
    # print(took)