FROM adoptopenjdk/openjdk11 AS builder
COPY . .
RUN chmod +x gradlew
RUN ./gradlew clean build -x test

FROM adoptopenjdk/openjdk11
COPY --from=builder build/libs/TTT-0.0.1-SNAPSHOT.jar TTT-0.0.1-SNAPSHOT.jar

ARG JAR_FILE=build/libs/TTT-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} TTT-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/TTT-0.0.1-SNAPSHOT.jar"]
