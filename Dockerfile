#FROM jenkins/jenkins:lts-jdk11
#
#EXPOSE 22
#EXPOSE 8080
#
#USER root
#
#RUN apt-get update && \
#    apt-get -y install sudo
#
#RUN apt-get install -y wget
#RUN sudo apt-get install make
#RUN sudo apt-get install man -y
#
#RUN man curl | less +/--insecure
#
#
## Downloading and installing Maven
## 1- Define a constant with the version of maven you want to install
#ARG MAVEN_VERSION=3.8.5
#
## 2- Define a constant with the working directory
#ARG USER_HOME_DIR="/root"
#
## 4- Define the URL where maven can be downloaded from
#ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
#
## 5- Create the directories, download maven, validate the download, install it, remove downloaded file and set links
#RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
#    && echo "Downlaoding maven" \
#    && curl -fsSL -o /tmp/apache-maven.tar.gz -k ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
#    \
#    && echo "Unziping maven" \
#    && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
#    \
#    && echo "Cleaning and setting links" \
#    && rm -f /tmp/apache-maven.tar.gz \
#    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
#
## 6- Define environmental variables required by Maven, like Maven_Home directory and where the maven repo is located
#ENV MAVEN_HOME /usr/share/maven
#ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
#
## PARA EXECUÇÃO DA IMAGEM EM CONTAINER, FOI UTILIZADO:
## > docker run -p 8087:8080 -p 50000:50000 -v /var/jenkins_home --name MavenSpringHello maven_hello



#=======================================================================================================================
#=======================================================================================================================
#Ambiente Linux EC2 com JDK 11, Maven e Docker - Necessário apenas o build do projeto.

FROM adoptopenjdk/openjdk11:alpine-jre

ARG APP_NAME="hello"
ARG APP_VERSION="0.0.1-SNAPSHOT"
ARG JAR_FILE="/target/${APP_NAME}-${APP_VERSION}.jar"
#ARG JAR_FILE="/var/lib/jenkins${APP_NAME}-${APP_VERSION}.jar"

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "app.jar"]
