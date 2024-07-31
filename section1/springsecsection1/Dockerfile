FROM eclipse-temurin:21-jdk-alpine
RUN apk update && apk upgrade && apk add --upgrade openssl3
VOLUME /tmp
ARG JAR_FILE=datastore-3.5.jar
COPY target/${JAR_FILE} app.jar
ENTRYPOINT ["java", "-Xms128M", "-Xmx2560M", "-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]