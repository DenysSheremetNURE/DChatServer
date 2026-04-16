FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY target/DChat-server-view-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
