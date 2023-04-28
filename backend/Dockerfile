FROM adoptopenjdk/openjdk11
RUN cd /var/jenkins_home/workspace/ttt-staging/backend
RUN chmod +x gradlew
RUN gradlew clean build -x test

ARG JAR_FILE=build/libs/TTT-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} TTT.jar
ENTRYPOINT ["java","-jar","/TTT.jar"]
