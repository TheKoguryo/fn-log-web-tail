FROM ubuntu:24.04

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

RUN apt-get update -qq
RUN apt-get install -yq default-jdk
RUN export JAVA_HOME=/usr/lib/jvm/default-java

RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y gettext-base

RUN wget https://github.com/TheKoguryo/simple-socket-fn-logger/releases/download/v1.1.0/simple-socket-fn-logger-1.1.0-all.jar
RUN mv simple-socket-fn-logger-1.1.0-all.jar /app.jar
COPY simple-socket-fn-logger/logback.xml /

RUN wget https://github.com/sevdokimov/log-viewer/releases/download/v1.0.11/log-viewer-1.0.11.zip
RUN unzip log-viewer-1.0.11.zip
RUN mv log-viewer-1.0.11 log-viewer
COPY log-viewer/config.conf /log-viewer/
COPY log-viewer/logviewer.sh /log-viewer/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# run the process manager
CMD ["/usr/bin/supervisord"]
