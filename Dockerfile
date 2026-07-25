# ---  1: Construcción ---
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app
COPY . .

# PERMISO
RUN chmod +x ./gradlew

# Compila 
RUN ./gradlew bootJar -x test

# --- 2: Ejecucio´n ---
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]