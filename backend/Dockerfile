FROM adoptopenjdk/openjdk11 AS builder
COPY . .
RUN chmod +x gradlew
RUN ./gradlew clean build -x test

FROM adoptopenjdk/openjdk11
COPY --from=builder build/libs/TTT-0.0.1-SNAPSHOT.jar TTT.jar

ARG JAR_FILE=build/libs/TTT.jar
COPY ${JAR_FILE} TTT.jar
ENTRYPOINT ["nohup","java","-jar","/TTT.jar", "&"]
