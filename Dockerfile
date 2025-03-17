# 1) Gradle 빌드 스테이지
FROM --platform=linux/amd64 gradle:8.4-jdk17-alpine AS build
WORKDIR /app

COPY build.gradle settings.gradle ./
RUN gradle dependencies --no-daemon

COPY . /app
RUN gradle clean build --no-daemon

# 2) Temurin 17 런타임 스테이지
FROM --platform=linux/amd64 eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/agile.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","agile.jar"]
# https://babgeuleus.tistory.com/entry/CICD-%ED%8C%8C%EC%9D%B4%ED%94%84%EB%9D%BC%EC%9D%B8-%EA%B5%AC%EC%B6%95-Github-Actions-self-hosted-runners#%ED%85%8C%EC%8A%A4%ED%8A%B8%EA%B0%80-%ED%86%B5%EA%B3%BC%ED%95%B4%EC%95%BC-pr-merge%EA%B0%80-%EA%B0%80%EB%8A%A5%ED%95%98%EB%8F%84%EB%A1%9D-%EC%84%A4%EC%A0%95