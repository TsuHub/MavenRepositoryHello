#=======================================================================================================================
#Ambiente Linux EC2 com JDK 11, Maven e Docker - Necessário apenas o build do projeto.

FROM adoptopenjdk/openjdk11:alpine-jre

ARG APP_NAME="hello"
ARG APP_VERSION="latest"
ARG JAR_FILE="/target/${APP_NAME}-${APP_VERSION}.jar"
#ARG JAR_FILE="/var/lib/jenkins${APP_NAME}-${APP_VERSION}.jar"

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "app.jar"]

