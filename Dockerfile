FROM adoptopenjdk:11-jre-hotspot

RUN apt update

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]