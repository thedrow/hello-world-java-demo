# first stage - build the hello world program
FROM maven:3-amazoncorretto-8 as builder

# working directory (in the container)
WORKDIR /app
COPY ./ .

# compile
RUN --mount=type=cache,target=/root/.m2 mvn package

# second stage - create the final image
# use jre only without jdk
FROM amazoncorretto:8-alpine-jre as webRunnner

WORKDIR /app
# copy compiled file from the previuos image
COPY --from=builder /app/target/spring-boot-mysql-v3.jar .

# set the entrypoint to run the java class
ENTRYPOINT ["java", "-jar", "spring-boot-mysql-v3.jar"]