FROM python:3.6
MAINTAINER adnanrimedzo
WORKDIR /
RUN   apt-get update && \
      apt-get install -y \
      build-essential \
      cmake \
      libtbb2 \
      libtbb-dev \
      libjpeg-dev \
      libpng-dev \
      libjasper-dev \
      libtiff-dev \
      git

RUN   pip install numpy
COPY  makeopencv.sh ./
RUN   ["./makeopencv.sh", "3.2.0"]

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["run.py"]