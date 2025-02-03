FROM python:3.9.1

RUN apt-get install
RUN pip install pandas sqlalchemy psycopg2-binary pyarrow

WORKDIR /app
COPY upload_data.py upload_data.py

ENTRYPOINT [ "python", "upload_data.py" ]