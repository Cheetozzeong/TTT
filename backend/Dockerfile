FROM adoptopenjdk/openjdk11 AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
COPY application.properties src/main/resources/application.properties
COPY serviceAccountKey.json src/main/resources/serviceAccountKey.json
RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM adoptopenjdk/openjdk11
COPY --from=builder build/libs/TTT-0.0.1-SNAPSHOT.jar TTT.jar

ENTRYPOINT ["java","-jar","/TTT.jar"]