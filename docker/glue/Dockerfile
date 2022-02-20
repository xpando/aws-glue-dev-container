FROM local/amazonlinux-python37

ARG APPUSER=glue

ADD scripts /tmp

RUN yum -y update && \
    yum install -y which tar gzip unzip zip && \
    /tmp/install-java.sh && \
    /tmp/install-glue-libs.sh

ADD rootfs /

RUN source /app/venv/bin/activate && \
    pip install --no-cache-dir -r /app/requirements.txt && deactivate && \
    curl -L https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.0.1/delta-core_2.12-1.0.1.jar -o /app/lib/java/delta-core_2.12-1.0.1.jar && \
    yum install -y shadow-utils && \    
    groupadd ${APPUSER} && useradd ${APPUSER} -g ${APPUSER} && \
    mkdir -p /data && \
    mkdir -p /project && \
    chown -R ${APPUSER}:${APPUSER} /app && \
    chown -R ${APPUSER}:${APPUSER} /data && \
    chown -R ${APPUSER}:${APPUSER} /project && \
    yum remove -y shadow-utils && \
    yum -y autoremove && yum clean all

USER ${APPUSER}
ENTRYPOINT ["/entrypoint.sh"]
