FROM shoothzj/compile:jdk17-mvn AS compiler

RUN git clone --depth 1 --branch hzj-pg https://github.com/shoothzj/apollo.git && \
    cd apollo && \
    mvn -B clean package -DskipTests=true && \
    mkdir /opt/apollo

COPY docker-build /opt/apollo/mate

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/apollo/mate/scripts/start.sh"]
