FROM openjdk:8-jdk-alpine
VOLUME /tmp
RUN mkdir /app
COPY target/*.jar /app/app.jar
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
#set timezone
RUN echo "Asia/shanghai" > /etc/timezone;

ENTRYPOINT ["/entrypoint.sh"]


