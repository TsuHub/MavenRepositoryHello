#=======================================================================================================================
#
#       Este Dockerfile está funcionando bem, só dá um problema no Jenkins, da falta
#       do Gradle Assemble. Mas é o melhor até agora. Ele está rodando no container:
#       'JenkinsGradleHello2' e sua imagem está como 'hello_gradle'.
#
#=======================================================================================================================
#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
# Com alteração do de cima, para poder acessar com a senha do sudo (no linux do container)
FROM openjdk:11-jdk

ARG APP_NAME="hello-0.0.1-SNAPSHOT"
ARG JAR_FILE="/target/${APP_NAME}.jar"

#RUN echo 'root:Docker!' | chpasswd
#               ou
#RUN echo 'Docker!' | passwd --stdin root

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "app.jar"]

#=======================================================================================================================
#Bloco para instalar o jenkins junto com a permissão do sudo. Instruções da documentação: https://www.jenkins.io/doc/book/installing/docker/
FROM jenkins/jenkins:2.332.2-jdk11
USER root

RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get install -y lsb-release && \
    apt-get install -y wget && \
    apt-get install -y nano

RUN adduser --disabled-password --gecos '' docker           # Para o sudo : Liberação de senha para usuário docker adicionado no registro
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
# Bloco para o Jenkins

RUN adduser jenkins sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#=======================================================================================================================
# Link de download : https://maven.apache.org/download.cgi
# Guia de instalação : https://maven.apache.org/install.html
#RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.zip #-P /tmp && \
#RUN sudo unzip apache-maven-3.8.5-bin.zip
#
#RUN echo 'export M2_HOME=/opt/apache-maven-3.8.5' >> ~/.bashrc && \
#    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> ~/.bashrc
#RUN echo 'mvn -v'
#
#    # ou \
##RUN echo 'export PATH=/opt/apache-maven-3.8.5/bin:$PATH'

FROM openjdk:11-jdk

ARG MAVEN_VERSION=3.8.5
ARG USER_HOME_DIR="/root"
ARG SHA=89ab8ece99292476447ef6a6800d9842bbb60787b9b8a45c103aa61d2f205a971d8c3ddfb8b03e514455b4173602bd015e82958c0b3ddc1728a57126f773c743
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]