# Use a lightweight base image for Java applications
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot application JAR into the container
COPY ./target/my-spring-boot-app.jar /app/

# Expose the port of your Spring Boot application 
EXPOSE 8080

# Command to run your Spring Boot application
ENTRYPOINT ["java", "-jar", "my-spring-boot-app.jar"]
