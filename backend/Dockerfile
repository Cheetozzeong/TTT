FROM adoptopenjdk/openjdk11
ARG JAR_FILE=build/libs/TTT-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} TTT.jar
ENTRYPOINT ["java","-jar","/TTT.jar"]