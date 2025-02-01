# Use a lightweight image to build the app
FROM maven:3.8.4-eclipse-temurin-17-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy pom.xml and download dependencies to cache them in a separate layer
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copy the source code and build the application without tests
COPY src ./src
RUN mvn package -DskipTests -q

# Use a smaller JDK runtime for the final image
FROM eclipse-temurin:17-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the current stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/demo.jar"]

