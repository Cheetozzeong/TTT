FROM adoptopenjdk/openjdk11

RUN chmod +x gradlew
RUN gradlew clean build -x test

ARG JAR_FILE=build/libs/TTT-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} TTT.jar
ENTRYPOINT ["nohup","java","-jar","/TTT.jar", "&"]
