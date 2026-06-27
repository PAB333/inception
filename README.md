*This project has been created as part of the 42 curriculum by pibreiss*

## Description
Inception is a system administration project focused on deploying a small, fully functional web infrastructure using Docker. The goal is to move away from installing services directly on a virtual machine and instead containerize them. 

For this project, I built a setup consisting of three main services: NGINX as the web server, WordPress (with php-fpm) for the website, and MariaDB for the database. Each service runs in its own isolated container, built from scratch using a custom Debian Bookworm image.

## Instructions
To get this infrastructure up and running on your local machine, follow these steps:

1. Make sure your local domain name (`pibreiss.42.fr`) points to `127.0.0.1` in your `/etc/hosts` file.
2. Clone the repository and navigate to the root folder.
3. Copy the `srcs/.env.example` file to create a `srcs/.env` file, and fill in the necessary configuration variables.
4. Open the `secrets/` directory and populate the text files (`db_password.txt`, `db_root_password.txt`, `credentials.txt`) with your actual passwords.
5. Simply run `make` at the root of the project. This will build the images, create the necessary local folders for the volumes, and spin up the containers in the background.
6. Open your browser and access the site at `https://pibreiss.42.fr` (you will need to accept the self-signed SSL certificate).

To stop the containers, use `make down`. To completely clean the system (including volumes), use `make fclean`.

## Resources
Building this infrastructure required a lot of research. I mainly relied on the official documentation for Docker and Docker Compose, as well as the documentation for NGINX, WordPress, and MariaDB.

I used AI to create a plan for the project's development and also to understand certain concepts.

## Project description
The core idea of this project is to orchestrate multiple services so they can work together securely and efficiently. Here is a breakdown of the main architectural choices I applied:

* **Virtual Machines vs Docker:** A traditional VM emulates an entire operating system, making it quite heavy and slow to boot. Docker, on the other hand, isolates processes while sharing the host's OS kernel. It is much lighter, starts in seconds, and ensures the environment is strictly reproducible everywhere.
* **Secrets vs Environment Variables:** I used environment variables in my `.env` file for non-sensitive data, like the domain name or database user names. However, for database passwords and admin credentials, I used Docker Secrets. Unlike environment variables, which can easily leak if you inspect the container, secrets are securely mounted into the container's memory (under `/run/secrets/`), making the whole setup much safer.
* **Docker Network vs Host Network:** All containers communicate via a dedicated internal Docker bridge network (`inception_network`). This means they can resolve each other simply by their container names. Using `network: host` would have stripped away this isolation, exposing all internal ports to the host machine. Thanks to the bridge network, only NGINX exposes port 443 to the outside world.
* **Docker Volumes vs Bind Mounts:** To ensure that the database and the website files aren't wiped out when a container crashes or is stopped, I used Docker named volumes. While a standard bind mount directly links a host folder to the container, named volumes are fully managed by Docker, providing better data portability and safety. As required by the subject, these volumes are configured with a specific local driver to store the physical data safely in `/home/pibreiss/data` on the host machine.