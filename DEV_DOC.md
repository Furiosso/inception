# DEV_DOC.md

## Overview

This document describes how a developer can set up, build, and manage the Inception project from scratch. It explains prerequisites, configuration, container management, and data persistence.

---

## Prerequisites

Before starting, the following tools must be installed on the system:

- Docker
- Docker Compose
- GNU Make
- Git

Optional tools include a web browser for service access and a FTP client in order to make tests for the FTP bonus.

This line must be included in the /etc/hosts file:

```bash
127.0.0.1  daniel.42.fr
```

---

## Environment Setup

1. Clone the project repository to the local machine.
2. Move into the project root directory.
3. Create an .env file making a copy of the .env.template file and filling in all the sections with the user's info.

.env must never be committed to version control.

---

## Building and Launching the Project

The project is built and launched using the Makefile provided at the root of the repository.

This process:
- Builds all Docker images from their respective Dockerfiles
- Creates Docker volumes for persistent data
- Creates the custom Docker network
- Starts all containers defined in the Docker Compose configuration

---

## Managing Containers and Services

Developers can manage the stack using standard Docker and Docker Compose commands, including:

- Listing running containers
- Inspecting container logs
- Executing an interactive shell inside a container
- Stopping or restarting individual services

Portainer can also be used as a graphical interface for container and volume management.

---

## Data Storage and Persistence

Persistent application data is stored using Docker volumes. These volumes ensure that data is preserved across container restarts or rebuilds.

### Volume Usage by Service

- **MariaDB**  
  Stores all database files and ensures database persistence.

- **WordPress**  
  Stores uploaded media, themes, and plugins.

- **Redis**  
  Stores cached data used to improve application performance.

- **Portainer**  
  Stores Portainer configuration, metadata, and access settings.

Volumes are managed by Docker and are independent of the host filesystem structure.

---

## Developer Notes

- Redis is used internally and generally does not require direct developer interaction.
- Any change to Dockerfiles, configuration files, or the Docker Compose setup requires rebuilding the project.
- Nginx is responsible for TLS termination and routing requests to internal services, while administrative control tools such as vsftpd, Adminer and Portainer are accesed separately.
- Docker volumes should be handled carefully, as removing them results in permanent data loss.
