FROM amazonlinux:latest AS build

ARG APPUSER=glue-user

# Install runtime packages
ADD build /root
RUN yum -y update && \
    yum install -y shadow-utils vim which tar gzip unzip zip python37 && \
    /root/install-java.sh

# Download AWS Glue dependencies
RUN /root/download-dependencies.sh

ADD app /app
RUN python3 -m venv /app/venv && \
    source /app/venv/bin/activate && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt && deactivate

RUN groupadd ${APPUSER} && useradd ${APPUSER} -g ${APPUSER} && \
    mkdir -p /data /project /home/${APPUSER}/.aws && \
    chown -R ${APPUSER}:${APPUSER} /app && \
    chown -R ${APPUSER}:${APPUSER} /data && \
    chown -R ${APPUSER}:${APPUSER} /project && \
    chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/.aws

COPY entrypoint.sh /
USER ${APPUSER}
ENTRYPOINT ["/entrypoint.sh"]
