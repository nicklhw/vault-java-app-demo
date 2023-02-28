FROM openjdk:17 as build

WORKDIR /src
COPY . /src

RUN ./mvnw clean package

FROM openjdk:17

RUN mkdir /app
WORKDIR /app

COPY --from=build /src/target/spring-vault-demo-0.0.1-SNAPSHOT.jar /app/spring-vault-demo-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "/app/spring-vault-demo-0.0.1-SNAPSHOT.jar"]