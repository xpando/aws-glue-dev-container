FROM amazonlinux:latest

RUN yum -y update && yum install -y python37 && yum -y autoremove && yum clean all && \
    mkdir /app && \
    python3 -m venv /app/venv && \
    source /app/venv/bin/activate && \
    pip install --no-cache-dir --upgrade pip

COPY entrypoint.sh /entrypoint.sh
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
