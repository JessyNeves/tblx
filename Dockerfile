# Pull base image
FROM ubuntu

# Default environment variables
ENV ORIGIN_AIRPORT JFK
ENV DESTINATION_AIRPORT ORD
ENV PREPARE 0

COPY . .

# Install PIP
RUN apt-get -y update
RUN apt-get install python3-pip -y

# Install python dependencies
RUN pip3 install pyspark

# Non-Interactive installation
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

# Install Java 8 (Pyspark Dependency)
RUN \
    apt-get update && \
    apt-get install -y openjdk-8-jre && \
    rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Run pyspark script
CMD python3 ./main.py ${ORIGIN_AIRPORT} ${DESTINATION_AIRPORT} ${PREPARE}