#syntax=docker/dockerfile:1

# FROM debian:bookworm-slim

# # Dependencias mínimas
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends ca-certificates tzdata && \
#     rm -rf /var/lib/apt/lists/*

# # Descargar Portainer (versión actualizada, la 2.21.2 ya es vieja; usa la latest o una reciente)
# ARG PORTAINER_VERSION=2.21.3  # O quita el ARG y usa latest si prefieres
# ADD https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz /tmp/portainer.tar.gz

# RUN tar -xzvf /tmp/portainer.tar.gz -C /opt && \
#     mv /opt/portainer /opt/portainer-bin && \
#     chmod +x /opt/portainer-bin/portainer && \
#     rm /tmp/portainer.tar.gz

# # NO creamos usuario no-root → corre como root (solución al permission denied)

# WORKDIR /opt/portainer-bin

# VOLUME /data

# EXPOSE 9443

# CMD ["/opt/portainer-bin/portainer", "--data", "/data"]
# syntax=docker/dockerfile:1
# FROM debian:bookworm-slim

# # Instalar dependencias mínimas + htpasswd para generar el hash bcrypt
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         ca-certificates \
#         tzdata \
#         apache2-utils \
#         curl \
#     && rm -rf /var/lib/apt/lists/*

# # Descargar Portainer (versión reciente estable)
# ARG PORTAINER_VERSION=2.33.6
# ADD https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz /tmp/portainer.tar.gz

# RUN tar -xzvf /tmp/portainer.tar.gz -C /opt && \
#     mv /opt/portainer /opt/portainer-bin && \
#     chmod +x /opt/portainer-bin/portainer && \
#     rm /tmp/portainer.tar.gz

# # Copiar nuestro script de arranque
# COPY tools/start_portainer.sh /start_portainer.sh
# RUN chmod +x /start_portainer.sh

# WORKDIR /opt/portainer-bin

# VOLUME /data

# EXPOSE 9443 8000

# # El script configura el admin si es necesario y luego ejecuta Portainer
# ENTRYPOINT ["/start_portainer.sh"]
# CMD ["/opt/portainer-bin/portainer"]
#syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        tzdata \
        curl \
        wget \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/portainer/portainer/releases/download/2.21.3/portainer-2.21.3-linux-amd64.tar.gz /tmp/portainer.tar.gz

RUN tar -xzvf /tmp/portainer.tar.gz -C /opt \
    && mv /opt/portainer /opt/portainer-bin \
    && chmod +x /opt/portainer-bin/portainer \
    && rm /tmp/portainer.tar.gz

WORKDIR /opt/portainer-bin

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /data
EXPOSE 9443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/opt/portainer-bin/portainer"]
