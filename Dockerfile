FROM shoothzj/compile:jdk17-mvn AS compiler

RUN git clone --depth 1 --branch introduce-h2-postgre-properties https://github.com/shoothzj/apollo.git && \
    cd apollo && \
    mvn -B clean package -DskipTests=true && \
    mkdir /opt/apollo

FROM shoothzj/base:jdk17

COPY --from=compiler /apollo/apollo-configservice/target/apollo-configservice-2.2.0-SNAPSHOT.jar /opt/apollo/admin/apollo-configservice.jar
COPY --from=compiler /apollo/apollo-adminservice/target/apollo-adminservice-2.2.0-SNAPSHOT.jar /opt/apollo/admin/apollo-adminservice.jar
COPY --from=compiler /apollo/apollo-portal/target/apollo-portal-2.2.0-SNAPSHOT.jar /opt/apollo/admin/apollo-portal.jar

COPY docker-build /opt/apollo/mate

WORKDIR /opt/apollo

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/apollo/mate/scripts/start.sh"]
