#The base image - The container is built on top of this image --# reference: https://hub.docker.com/_/ubuntu/
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
    freetds-dev \
    vim \
    sudo \
    nodejs \
    npm \
    net-tools \
    flex \
    perl \
    automake \
    bison \
    libtool \
    byacc

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#Installing Python and PIP
RUN apt-get update && apt-get install -y \
    python3.6 \
    python3-pip

RUN pip3 install \
scipy \
numpy \
matplotlib \
pandas \
statsmodels \
sklearn \
theano \
tensorflow \
keras \
xgboost \
shap \
jupyterlab \
torch \
torchvision \
scikit-plot \
arff2pandas

RUN apt-get update && apt-get install -y libv8-3.14-dev \
libcurl4-gnutls-dev \
libxml2-dev


RUN apt-get update && apt-get install -y graphviz && wget http://kr.archive.ubuntu.com/ubuntu/pool/universe/g/graphviz/graphviz_2.40.1-2_amd64.deb && dpkg -i graphviz_2.40.1-2_amd64.deb

RUN apt-get update && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata && apt-get install -y software-properties-common && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && apt-get install -y r-base

RUN pip3 install rpy2

RUN R -e "install.packages(c('roxygen2', 'rversions'))"
RUN R -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))"
RUN R -e "devtools::install_github('IRkernel/IRkernel')"
RUN R -e "IRkernel::installspec()"
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('Rgraphviz')"

