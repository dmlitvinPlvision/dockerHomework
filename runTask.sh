#!/bin/bash

# Import image from git repository
sudo docker image import - untared_alpine_image < ball.tar

# Create custom bridge network
sudo docker network create my_bridge

# Run server container
sudo docker run -id --network my_bridge --name server -v $"$(pwd)"/serverMountPoint:/mountPoint untared_alpine_image /bin/sh

# Run client container
sudo docker run -id --network my_bridge --name client -v $"$(pwd)"/clientMountPoint:/mountPoint untared_alpine_image /bin/sh

# Start listening for file from server side
sudo docker container exec -d server /mountPoint/listenForFile.sh

# Connect to server and transfer data
sudo docker container exec -d client /mountPoint/sendFile.sh

# Wait for file being transfered
sleep 1

# Check file after transfer
sudo docker container exec -it server /mountPoint/checkTransferedFile.sh
