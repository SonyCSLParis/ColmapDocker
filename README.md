### Dockerfile for deep learning using colmap

#### List of commands:

1. Build the image

`docker build -t colmap:latest .`

2. Run the container

`nvidia-docker run --name=radis -v /path/to/images/on/host:/mount/point/on/container colmap:latest`

3. Stop Container

`docker stop CONTAINER_ID`

or

`docker stop radis`


> Get container id : `docker ps`

> List all docker images : `docker images`

> Remove Docker image : `docker rmi IMAGE_ID`
> List all images to get image id.
