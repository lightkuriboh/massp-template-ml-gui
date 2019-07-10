FROM ubuntu:latest
MAINTAINER KuribohKute "kuribohwithwing@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
RUN apt-get install -y libsm6 libxext6 libxrender-dev
COPY . /app
WORKDIR /app
RUN pip install Flask
RUN pip install numpy
RUN pip install opencv-python
RUN pip install scikit-image
RUN pip install matplotlib
RUN pip install scipy
ENTRYPOINT ["python"]
CMD ["app.py"]
