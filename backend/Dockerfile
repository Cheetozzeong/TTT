FROM adoptopenjdk/openjdk11 AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM adoptopenjdk/openjdk11
COPY --from=builder build/libs/TTT-0.0.1-SNAPSHOT.jar TTT-0.0.1-SNAPSHOT.jar.jar

ENTRYPOINT ["java","-jar","/TTT-0.0.1-SNAPSHOT.jar"]