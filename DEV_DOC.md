# Developer Documentation

## Setting up the Environment from Scratch
To deploy this infrastructure on a new machine, follow these setup steps:
1. **Prerequisites:** Ensure Docker and Docker Compose are installed on the host machine. You also need to map the local domain `pibreiss.42.fr` to `127.0.0.1` by adding it to your `/etc/hosts` file.
2. **Configuration:** Copy the provided `srcs/.env.example` file to create a new `srcs/.env` file, and fill in the necessary environment variables.
3. **Secrets:** Create the required text files inside the `secrets/` directory (`db_password.txt`, `db_root_password.txt`, and `credentials.txt`) and populate them with strong passwords. These files are ignored by Git for obvious security reasons.

## Building and Launching the Project
The entire deployment process is automated via the `Makefile` located at the root of the repository. 
By simply running `make`, the script will create the necessary host directories for data storage and trigger `docker compose -f srcs/docker-compose.yml up -d --build`. This builds the custom Docker images from their respective Dockerfiles and launches the containers in the background.

## Container and Volume Management
Here are the primary commands you'll need to manage the lifecycle of the infrastructure:
* `make down`: Stops and removes the containers and the default network, but leaves the volumes intact.
* `make clean`: Performs a `make down` and prunes unused Docker resources.
* `make fclean`: Completely wipes the infrastructure. It stops containers, removes all images, deletes the persistent volumes, and cleans the physical data folders on the host machine.
* `docker exec -it <container_name> bash`: Opens a terminal session inside a running container, which is incredibly useful for live debugging.

## Data Storage and Persistence
To ensure data is not lost when containers crash, are stopped, or recreated, the project uses Docker named volumes (`mariadb_data` and `wordpress_data`). 
These volumes are configured to bind directly to the host machine's filesystem at `/home/pibreiss/data/mariadb` and `/home/pibreiss/data/wordpress`. Because the data physically lives on the host machine, the database content and the WordPress files (like themes and uploads) will naturally persist across container restarts and system reboots.