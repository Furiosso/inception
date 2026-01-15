# USER_DOC.md

## Overview

This document provides instructions for end users or administrators to understand, access, and manage the Inception project. The stack is composed of multiple services, each running in its own Docker container and connected through a dedicated Docker network.

### Services Provided

- **Nginx**  
  Acts as a reverse proxy and HTTPS server. It is the only service exposed to the host and serves both WordPress and the static website.

- **WordPress (PHP-FPM)**  
  Content management system used to create and manage dynamic website content.

- **MariaDB**  
  Relational database used by WordPress to store application data.

- **Redis**  
  In-memory data store used for caching to improve WordPress performance.

- **vsftpd**  
  FTP service allowing file transfers to the WordPress data volume.

- **Adminer**  
  Web-based database administration interface for MariaDB.

- **Portainer**  
  Web interface used to monitor and manage Docker containers, volumes, and networks.

- **Static Website (Bonus)**  
  A simple HTML and CSS website served directly by Nginx.

---

## Starting and Stopping the Project

### Starting the Stack

From the root of the repository, the project can be started using the Makefile. 

```bash
make
 ```

This command builds all Docker images and starts every service defined in the Docker Compose configuration.

After startup, all containers should be running and connected to the internal Docker network. Check it out with the following command:

```bash
docker ps
 ```

### Stopping the Stack and remove the containers

The project can be stopped using the Makefile as well. 

```bash
make down
 ```

This stops and removes all running containers and networks, while keeping the images and persistent data stored in Docker volumes.

### Restarting the containers

If you want to stop and remove the containers and run them again immediately after type:

```bash
make restart
 ```

### Stopping the Stack and remove the containers and the images

To remove the images apart from the Docker volumes and the network run this command (always in the root file).

```bash
make fclean
 ```
### Restarting the stack

 To remove everything and build it and run it again do

 ```bash
make re
 ```
### Building the images

 To build the images but not run them type

 ```bash
make build
 ```

 ### Stopping the containers the containers

 To stop the containers without removing them do:

 ```bash
make stop
 ```
### Restarting the containers

 To start them again:

 ```bash
make start
 ```
---

## Accessing the Services

- **WordPress**  
  Accessible through `https://dagimeno.42.fr` . This interface is used to manage website content.

 **WordPress Administration Panel**  
  Accessible through `https://dagimeno.42.fr/wp-admin`

- **Static Website**  
  Accessible through `https://dagimeno.42.fr/cv`. It displays a simple static HTML and CSS curriculum.

- **Adminer**  
  Accessible through `http://dagimeno.42.fr:8080`. It allows database management through a web browser.

- **Portainer**  
  Accessible through `https://dagimeno.42.fr:9443` and used to monitor containers, images, volumes, and networks.

- **vsftpd**  
  Accessible through the terminal by `http://dagimeno.42.fr:21` and the configured credentials to transfer files to the WordPress data directory.

---

## Locating and Managing Credentials

- Passwords and credentials are stored in an .env file. This file must be created making a copy of the .env.template file and filling in all the sections, otherwise it will not work. 
- TLS certificates are created, stores and managed using a Docker Secrets simulation automatically when the stack is started.

---

## Verifying Service Status

To verify that the project is running correctly:

- Ensure all containers are running using 
```bash
docker ps
```
- Access WordPress, the static website, Adminer, and Portainer via a web browser.

---

## Notes

- Persistent data is stored using Docker volumes and is not lost when containers are stopped or rebuilt.
- Redis operates internally and does not require user interaction.
