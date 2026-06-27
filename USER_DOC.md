# User Documentation

## Provided Services
This infrastructure provides a complete, containerized web stack. It consists of three main components working together: an NGINX web server acting as the secure entry point, a fully functional WordPress website, and a MariaDB database running quietly in the background to securely store the site's data.

## Starting and Stopping the Project
* **To start the infrastructure:** Simply open your terminal, navigate to the root folder of the project, and run the `make` command.
* **To stop the infrastructure:** Run `make down`. This safely stops the containers without losing any of your data.

## Accessing the Website
* **Public Website:** Open your web browser and navigate to `https://pibreiss.42.fr`. Since the project uses a self-signed SSL certificate, your browser will likely show a security warning. You can safely accept the risk and bypass this to view the site.
* **Admin Panel:** To manage the WordPress site, go to `https://pibreiss.42.fr/wp-admin`. You can log in using the administrator credentials you set up (for example, the username `godmod`).

## Managing Credentials
To keep the system secure, all sensitive passwords (database root password...) are stored in local text files inside the `secrets/` directory. General configuration details, like the domain name, are managed in the `.env` file located in the `srcs/` folder.

## Checking the Service Status
If you want to make sure everything is running smoothly, open your terminal and run `docker ps`. This will list all active containers. If a service isn't working as expected, you can check its specific logs to spot the error by running `docker logs <container_name>` (for example, `docker logs wordpress`).