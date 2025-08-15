FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y supervisor
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

RUN mkdir temp
WORKDIR /temp
RUN jar xf /log-viewer/lib/log-viewer-frontend-1.0.11.jar
COPY log-viewer/d2coding.css log-viewer-web/
COPY log-viewer/index.html log-viewer-web/
COPY log-viewer/main.a494d4a6ae05f683.js log-viewer-web/
COPY log-viewer/styles.662fbe794f1a8626.css log-viewer-web/
RUN jar cf log-viewer-frontend-1.0.11.jar -C . .
RUN cp log-viewer-frontend-1.0.11.jar /log-viewer/lib/
RUN rm -rf /temp

WORKDIR /

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# run the process manager
CMD ["/usr/bin/supervisord"]
