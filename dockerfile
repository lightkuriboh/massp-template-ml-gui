FROM ubuntu:latest
MAINTAINER KuribohKute "kuribohwithwing@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
RUN apt-get install -y libsm6 libxext6 libxrender-dev
RUN apt-get install -y python-tk
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app
RUN chmod 644 app.py
ENTRYPOINT ["python"]
CMD ["-m", "flask", "run", "--host", "0.0.0.0"]