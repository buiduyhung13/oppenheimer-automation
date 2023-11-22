FROM openjdk:21-jdk

WORKDIR /app

ADD https://github.com/auronsiow/oppenheimer-project-dev/raw/master/OppenheimerProjectDev.jar ./OppenheimerProjectDev.jar

EXPOSE 8080
CMD [ "java", "-jar", "./OppenheimerProjectDev.jar" ]