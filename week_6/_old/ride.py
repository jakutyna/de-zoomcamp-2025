from typing import List, Dict
from decimal import Decimal
from datetime import datetime


class Ride:
    def __init__(self, arr: List[str]):
        # self.lpep_pickup_datetime = datetime.strptime(arr[0], "%Y-%m-%d %H:%M:%S"),
        # self.lpep_dropoff_datetime = datetime.strptime(arr[1], "%Y-%m-%d %H:%M:%S"),
        # self.PULocationID = int(arr[2])
        # self.DOLocationID = int(arr[3])
        # self.passenger_count = int(arr[4])
        # self.trip_distance = Decimal(arr[5])
        # self.tip_amount = Decimal(arr[6])

        self.lpep_pickup_datetime = datetime.strptime(arr[1], "%Y-%m-%d %H:%M:%S"),
        self.lpep_dropoff_datetime = datetime.strptime(arr[2], "%Y-%m-%d %H:%M:%S"),
        self.PULocationID = None if arr[5] == "" else int(arr[5])
        self.DOLocationID = None if arr[6] == "" else int(arr[6])
        self.passenger_count = None if arr[7] == "" else int(arr[7])
        self.trip_distance = Decimal(arr[8])
        self.tip_amount = Decimal(arr[12])

    @classmethod
    def from_dict(cls, d: Dict):
        return cls(arr=[
            d['lpep_pickup_datetime'][0],
            d['lpep_dropoff_datetime'][0],
            d['PULocationID'],
            d['DOLocationID'],
            d['passenger_count'],
            d['trip_distance'],
            d['tip_amount'],
        ]
        )

    def __repr__(self):
        return f'{self.__class__.__name__}: {self.__dict__}'
