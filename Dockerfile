FROM ubuntu:18.04

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

RUN apt-get update -qq
RUN apt-get install -yq default-jdk
RUN export JAVA_HOME=/usr/lib/jvm/default-java

RUN apt-get install -y wget
RUN apt-get install -y unzip

RUN wget https://github.com/recursivecodes/simple-socket-fn-logger/releases/download/v1.0.0/simple-socket-fn-logger-1.0.0-all.jar
RUN mv simple-socket-fn-logger-1.0.0-all.jar /app.jar
COPY logback.xml /

RUN wget https://github.com/mishankov/web-tail/releases/download/v0.5.0/web-tail-0.5.0-linux.zip
RUN unzip web-tail-0.5.0-linux.zip
COPY web-tail.config.json /

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# run the process manager
CMD ["/usr/bin/supervisord"]
