#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

# Dependencias mínimas
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates tzdata && \
    rm -rf /var/lib/apt/lists/*

# Descargar Portainer (versión actualizada, la 2.21.2 ya es vieja; usa la latest o una reciente)
ARG PORTAINER_VERSION=2.21.3  # O quita el ARG y usa latest si prefieres
ADD https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz /tmp/portainer.tar.gz

RUN tar -xzvf /tmp/portainer.tar.gz -C /opt && \
    mv /opt/portainer /opt/portainer-bin && \
    chmod +x /opt/portainer-bin/portainer && \
    rm /tmp/portainer.tar.gz

# NO creamos usuario no-root → corre como root (solución al permission denied)

WORKDIR /opt/portainer-bin

VOLUME /data

EXPOSE 9443

CMD ["/opt/portainer-bin/portainer", "--data", "/data"]
