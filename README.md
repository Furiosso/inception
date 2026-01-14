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

- **Redis (Bonus)**  
  Used as an in-memory data store to handle WordPress caching and improve performance.

- **vsftpd (Bonus)**  
  Provides an FTP service allowing secure file transfers to the WordPress volume.

- **Adminer (Bonus)**  
  A lightweight database management interface used to administrate the MariaDB database through a web browser.

- **Portainer (Bonus)**  
  A container management interface used to monitor and manage Docker containers, images, networks, and volumes.

- **Static Website (Bonus)**  
  A simple static website written in HTML and CSS, served directly by Nginx without using PHP.

All services are connected through a **custom Docker bridge network**, allowing secure internal communication while preventing unnecessary exposure to the host system.


## Virtual Machines vs Docker

Virtual Machines (VMs) virtualize an entire operating system, including its own kernel, system libraries, and user space. Each VM runs on top of a hypervisor, which introduces significant overhead in terms of CPU, memory usage, disk space, and startup time. While VMs provide strong isolation, they are heavier and less efficient for deploying multiple lightweight services.

Docker containers, on the other hand, rely on operating-system-level virtualization. Containers share the host kernel while isolating processes, filesystems, and networks using Linux namespaces and cgroups. This approach makes containers significantly lighter, faster to start, and easier to scale.

Docker was chosen for this project because it allows deploying multiple independent services with minimal resource overhead, ensures reproducibility across environments, and reflects modern industry practices in application deployment and DevOps workflows.

## Secrets vs Environment Variables

Environment variables are commonly used to configure applications at runtime and are suitable for non-sensitive data such as service ports, container names, or feature flags. However, environment variables can be exposed through container inspection, logs, or misconfiguration, which makes them inappropriate for confidential data.

Docker Secrets provide a secure mechanism for managing sensitive information such as database passwords, WordPress credentials, and TLS certificates. Secrets are stored securely by Docker and mounted into containers at runtime as temporary in-memory files, reducing the risk of accidental exposure.

In this project, Docker Secrets are used to handle sensitive credentials and cryptographic material, improving overall security and ensuring that confidential data is not hardcoded into images or committed to version control.

## Docker Network vs Host Network

Using the host network mode removes network isolation between containers and the host system. While this can simplify configuration, it introduces several drawbacks, including port conflicts, reduced security, and tighter coupling between containers and the host environment.

Docker bridge networks provide an isolated virtual network layer where containers can communicate using internal DNS resolution and service names. Only explicitly exposed ports are accessible from the host, which reduces the attack surface and improves control over traffic flow.

This project uses a dedicated Docker bridge network to ensure clean separation between services, secure internal communication, and predictable networking behavior, while exposing only the Nginx service to the host.

## Docker Volumes vs Bind Mounts

Bind mounts map a specific host directory into a container. While simple to use, they tightly couple the container to the host filesystem structure, reduce portability, and may introduce permission or security issues when moving the project between systems.

Docker volumes are managed directly by Docker and exist independently of the host directory layout. They are portable, safer, and designed specifically for persistent application data. Volumes can be easily reused, backed up, or migrated without modifying container configurations.

In this project, Docker volumes are used to persist data for multiple services, including MariaDB, WordPress, Redis, vsftpd, Adminer, and Portainer. This ensures that application data, cache data, uploaded files, and service configurations remain available across container restarts and rebuilds, while keeping the infrastructure cleanly separated from the host filesystem.


## Instructions

### Requirements

- Docker
- Docker Compose
- GNU Make

### Build and Run

From the root of the repository, run:

``` bash
make

```
This command builds all Docker images, creates the required volumes and network, and starts the infrastructure.
To stop and clean up the containers, run:
```bash
make down

```
### Access
- WordPress: `https://dagimeno.42.fr`
- Wordpress administration: `https://dagimeno.42.fr/wp-admin`
- Adminer: `http://dagimeno.42.fr:8080`
- Portainer: `https://dagimeno.42.fr/9443`
- Static website (bonus): `https://dagimeno.42.fr/cv/`

## Resources

### Documentation and References

- Docker documentation: https://docs.docker.com
- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/

### Tutorials and other useful sources

- https://tuto.grademe.fr/inception/
- https://github.com/cfareste/Inception

### Use of Artificial Intelligence

Artificial Intelligence tools were used during this project to:
- Clarify Docker and Docker Compose concepts
- Review Nginx configuration logic
- Verify container security best practices
- Assist in structuring and writing the project documentation

All configuration files, architectural decisions, and implementation details were written, reviewed, and validated by the author.
