# --- 1: Construccii´on ---
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app
COPY . .
# Compilación
RUN ./gradlew bootJar -x test

# --- 2: Ejecución ---
FROM eclipse-temurin:21-jre
WORKDIR /app
# Copia el jar 
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]