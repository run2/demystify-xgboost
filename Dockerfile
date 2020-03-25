#The base image - The container is built on top of this image --# reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:18.04



# Install Ubuntu packages
RUN apt-get update && apt-get install -y wget bzip2 ca-certificates build-essential curl git-core htop pkg-config unzip unrar tree freetds-dev vim \
sudo nodejs npm net-tools flex perl automake bison libtool byacc

#Installing Python and PIP
RUN apt-get update && apt-get install -y \
    python3.6 \
    python3-pip

#Installing all ML python libraries , Jupyter and Extensions 
RUN pip3 install scipy numpy matplotlib pandas statsmodels sklearn theano tensorflow keras xgboost shap jupyterlab torch torchvision scikit-plot arff2pandas kaggle seaborn jupyter_contrib_nbextensions jupyter_nbextensions_configurator 

#Installing Ubunntu packages for Graphviz
RUN apt-get update && apt-get install -y libv8-3.14-dev \
libcurl4-gnutls-dev \
libxml2-dev

#Install Graphviz for python and R
RUN apt-get update && apt-get install -y graphviz && wget http://kr.archive.ubuntu.com/ubuntu/pool/universe/g/graphviz/graphviz_2.40.1-2_amd64.deb && dpkg -i graphviz_2.40.1-2_amd64.deb && pip3 install graphviz

#Install R
RUN apt-get update && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata && apt-get install -y software-properties-common && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && apt-get install -y r-base

#Install rpy2 to run R in pythong Kernels
RUN pip3 install rpy2

# Install R packages
RUN R -e "install.packages(c('xgboost','roxygen2', 'rversions','repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest','BiocManager','dplyr','ggplot2','tidyr','igraph','mice'))" && R -e "devtools::install_github('IRkernel/IRkernel')" && R -e "IRkernel::installspec()" && R -e "BiocManager::install('Rgraphviz')"

RUN apt-get update && apt-get install -y librsvg2-dev

RUN R -e "install.packages(c('DiagrammeR','DiagrammeRsvg','rsvg'))"

# Install GitHub
RUN apt-get update && apt-get upgrade -y && apt-get install -y git

# Install GCloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#ARG UID=1000
ARG LOGFILE=/ml-disk/jupyter.log

# Adds metadata to the image as a key value pair
LABEL version="1.0"

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Create empty directory to attach volume
RUN mkdir /ml-disk

# Setup User
RUN useradd -m -d /home/ml-user -s /bin/bash ml-user
# && echo "${user}:${pw}" | chpasswd

USER ml-user
WORKDIR /home/ml-user

## Setup Jupyter
RUN jupyter notebook --generate-config && jupyter nbextensions_configurator enable --user && jupyter contrib nbextension install --user
COPY --chown=ml-user jupyter_notebook_config.py /home/ml-user/.jupyter/jupyter_notebook_config.py
COPY --chown=ml-user mycert.pem /home/ml-user
COPY entryPoint.sh /root
USER root
WORKDIR /root


ENTRYPOINT ["sh","entryPoint.sh"]
