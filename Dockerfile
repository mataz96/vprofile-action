FROM maven:3.9-eclipse-temurin-8 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk8-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]