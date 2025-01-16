# void-together-docker

This repo provides a docker image for the multiplayer mod of Voices of the Void called Void Together.
The mod requires running your own dedicated server, which is containerized with this repo.

## Setup

You will need to update `VoidTogether-Server/serverconf.yml` to your preference,
as well as `VoidTogether-Server/permissions.json`. Refer to [the server repo](https://github.com/VoidTogether/VoidTogether-Server)
for more details on how to do that. I suppose you can do this after creating the Docker container by modifying
the config files inside the container.

After you have configured the server to your liking, you will need to run
`docker build -t <conatiner-name> <path to Dockerfile root>` to create the docker image.
If you want the image to be named `void-together` and the Dockerfile is located at `./void-together-docker/Dockerfile`,
Then you will run this command: `docker build -t void-together ./void-together-docker`.

To create a container from the image, I use DockSTARTer with the following added to my `.docker/compose/docker-compose.override.yml`:

```
services:
  void-together:
    container_name: void-together
    image: void-together:latest
    build:
      context: .
    environment:
      NODE_ENV: production
    ports:
      - 42069:42069
    networks:
      default: null
    restart: unless-stopped
```

Then `ds -c up void-together` and the container is running.
