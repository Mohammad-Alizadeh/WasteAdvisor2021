#builder image
FROM python:3.6-slim-stretch


RUN apt update
RUN apt install -y python3-dev gcc
ADD model.h5 model.h5
#install dependencies
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD app.py app.py
#setting up production image

RUN python app.py
RUN apk add -U --no-cache bash python3 python3-dev libpq postgresql-dev unixodbc-dev musl-dev g++ libffi-dev
&& pip3 install --upgrade --no-cache-dir pip setuptools==49.6.0
&& pip3 install --no-cache-dir -r requirements.txt
&& ln -s /usr/bin/python3 /usr/bin/python
&& apk del --no-cache python3-dev postgresql-dev unixodbc-dev musl-dev g++ libffi-dev
EXPOSE 8008

# Start the server
CMD ["python", "app.py", "serve"]
