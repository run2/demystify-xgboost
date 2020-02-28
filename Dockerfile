#The base image - The container is built on top of this image - # reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:18.04
# Adds metadata to the image as a key value pair
LABEL version="1.0"
# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
# Create empty directory to attach volume
RUN mkdir ~/Volume
# Install Ubuntu packages
RUN apt-get update && apt-get install -y \
 wget \
 bzip2 \
 ca-certificates \
 build-essential \
 curl \
 git-core \
 htop \
 pkg-config \
 unzip \
 unrar \
 tree \
 freetds-dev
 
# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#Installing Python and PIP
RUN apt-get update && apt-get install -y \
 python3.6 \
 python3-pip