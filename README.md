*This project has been created as part of the 42 curriculum by dagimeno.*

# Inception

## Description

Inception is a system administration and DevOps–oriented project whose objective is to introduce containerization using Docker and Docker Compose. The project consists of designing and deploying a small infrastructure composed of multiple services, each running in its own container and communicating through a dedicated Docker network.

The goal of the project is to understand how modern web applications are structured, deployed, secured, and isolated using containers, while respecting strict configuration and security constraints.

## Project Description and Design Choices

This project relies on Docker and Docker Compose to orchestrate a multi-service infrastructure. Each service is built from its own Dockerfile and follows the principle of one process per container.

### Included Services

- **Nginx**  
  Acts as a reverse proxy and HTTPS server. It is the only service exposed to the host and handles TLS termination.

- **WordPress (PHP-FPM)**  
  Hosts the WordPress application and communicates with the database through an internal Docker network.

- **MariaDB**  
  Provides persistent relational data storage for WordPress.

- **Static Website (Bonus)**  
  A simple static website written in HTML and CSS, served directly by Nginx without using PHP.

All services are connected through a **custom Docker bridge network**, allowing secure internal communication while preventing unnecessary exposure to the host system.

## Virtual Machines vs Docker

- **Virtual Machines** emulate full operating systems, including their own kernels, resulting in higher resource usage and slower startup times.
- **Docker containers** share the host kernel and isolate applications at the process level, making them lightweight, fast, and easily reproducible.

Docker was chosen for its efficiency, portability, and relevance in modern infrastructure.

## Secrets vs Environment Variables

- **Environment Variables** are suitable for non-sensitive configuration values.
- **Docker Secrets** are used to store sensitive data such as database credentials and TLS certificates.

Using secrets improves security by preventing sensitive information from being hardcoded into images or exposed through environment inspection.

## Docker Network vs Host Network

- **Host networking** removes network isolation and can lead to port conflicts and security risks.
- **Docker bridge networks** provide isolation, internal DNS resolution, and controlled communication between services.

This project uses a dedicated Docker network to ensure proper service separation and security.

## Docker Volumes vs Bind Mounts

- **Bind mounts** are directly tied to host filesystem paths and depend on the host environment.
- **Docker volumes** are managed by Docker, portable, and safer for storing persistent application data.

Docker volumes are used in this project to store MariaDB and WordPress data, ensuring persistence across container restarts and rebuilds.

## Instructions

### Requirements

- Docker
- Docker Compose
- GNU Make

### Build and Run

From the root of the repository, run:

```bash
make

---

### DOCUMENTO 9 — LÍNEA 4

```markdown
This command builds all Docker images, creates the required volumes and network, and starts the infrastructure.
To stop and clean up the containers, run:
```bash
make down

---

### DOCUMENTO 9 — LÍNEA 9

```markdown
### Access
- WordPress: `https://dagimeno.42.fr`
- Static website (bonus): `https://dagimeno.42.fr/cv/`

---

## DOCUMENTO 10 — Resources + AI usage

```markdown
## Resources

### Documentation and References

- Docker documentation: https://docs.docker.com
- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/

### Use of Artificial Intelligence

Artificial Intelligence tools were used during this project to:
- Clarify Docker and Docker Compose concepts
- Review Nginx configuration logic
- Verify container security best practices
- Assist in structuring and writing the project documentation

All configuration files, architectural decisions, and implementation details were written, reviewed, and validated by the author.
